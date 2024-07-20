module top_module
(
    input clk,
    input areset,
    input predict_valid,
    input predict_taken,
    output reg [31:0] predict_history,
    
    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);

always @(posedge clk or posedge areset) begin
    if (areset) begin
        predict_history <= 32'b0;
    end else if (train_mispredicted) begin
        // Load the history register with train_history concatenated with the actual result of the branch (train_taken)
        predict_history <= {train_history[30:0], train_taken};
    end else if (predict_valid) begin
        // Shift in predict_taken from the LSB side to update the branch history for the predicted branch
        predict_history <= {predict_history[30:0], predict_taken};
    end
end

endmodule
