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
        predict_history <= 32'd0;
    end else begin
        if (train_mispredicted) begin
            // If mispredicted, adjust the history with actual taken and train history
            predict_history <= {predict_history[30:0], train_taken} & train_history;
        end else if (predict_valid) begin
            // If prediction is valid, update history with the current prediction
            predict_history <= {predict_history[30:0], predict_taken};
        end
    end
end

endmodule
