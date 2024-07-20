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
            predict_history <= 0;
        end else if (train_mispredicted) begin
            // Load the train_history and concatenate train_taken at LSB
            predict_history <= {train_history[30:0], train_taken};
        end else if (predict_valid) begin
            // Shift in predict_taken to the predict_history register
            predict_history <= {predict_history[30:0], predict_taken};
        end
    end

endmodule
