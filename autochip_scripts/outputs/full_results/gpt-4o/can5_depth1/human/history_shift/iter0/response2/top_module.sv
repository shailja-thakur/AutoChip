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

    // History register to store the global history
    logic [31:0] history;

    // Asynchronous reset to reset the history register
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            history <= 32'b0;
        end else if (train_mispredicted) begin
            // Load branch history register with the history after the completion of the mispredicted branch
            history <= {train_history[30:0], train_taken};
        end else if (predict_valid) begin
            // Shift in predict_taken from the LSB side to update the branch history
            history <= {history[30:0], predict_taken};
        end
    end

    // Output the current value of the branch history register
    assign predict_history = history;

endmodule
