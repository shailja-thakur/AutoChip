module top_module
(
    input clk,
    input areset,
    input predict_valid,
    input predict_taken,
    output reg [31:0] predict_history,  // Use 'reg' instead of 'logic'
    
    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);

    always @(posedge clk or posedge areset) begin
        if (areset) begin                    // Reset the history counter to zero
            predict_history <= 0;
        end else if (train_mispredicted) begin
            predict_history <= {train_history[31:1], train_taken};  // Load the branch history register with the history after the completion of the mispredicted branch
        end else if (predict_valid) begin
            predict_history <= {predict_history[30:0], predict_taken};  // Shift in predict_taken from the LSB side to update the branch history for the predicted branch
        end
    end
endmodule
