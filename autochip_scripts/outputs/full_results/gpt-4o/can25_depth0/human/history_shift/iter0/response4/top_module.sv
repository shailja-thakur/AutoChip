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
            // Asynchronous reset: reset the history counter to zero
            predict_history <= 32'b0;
        end else if (train_mispredicted) begin
            // Rollback state on misprediction
            // Load history before the mispredicted branch concatenating with the actual result
            predict_history <= {train_history[30:0], train_taken};
        end else if (predict_valid) begin
            // Update history for a predicted branch
            // Shift in predict_taken from the LSB side
            predict_history <= {predict_history[30:0], predict_taken};
        end
    end

endmodule
