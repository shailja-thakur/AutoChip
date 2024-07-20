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
            predict_history <= 32'b0;  // Reset history to zero on asynchronous reset
        end else if (train_mispredicted) begin
            // Load branch history with the correct history after misprediction
            predict_history <= {train_history[30:0], train_taken};
        end else if (predict_valid) begin
            // Shift in the prediction result
            predict_history <= {predict_history[30:0], predict_taken};
        end
    end

endmodule
