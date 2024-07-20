module top_module
(
    input clk,
    input areset,
    input predict_valid,
    input predict_taken,
    output logic [31:0] predict_history,
    
    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);

always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        predict_history <= 32'b0;
    end else begin
        if (train_mispredicted) begin
            // Update the prediction history with the train_history and train_taken signals
            predict_history <= {train_history[30:0], train_taken};
        end else if (predict_valid) begin
            // Update the prediction history with the predict_taken signal
            predict_history <= {predict_history[30:0], predict_taken};
        end
    end
end

endmodule
