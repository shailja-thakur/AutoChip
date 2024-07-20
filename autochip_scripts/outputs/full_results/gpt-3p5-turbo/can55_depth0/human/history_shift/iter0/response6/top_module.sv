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

    // Define the global history shift register
    logic [31:0] history_reg;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset the history register to zero on positive edge of asynchronous reset
            history_reg <= 0;
        end else begin
            // Shift in the predict_taken value when predict_valid is high
            if (predict_valid) begin
                history_reg <= {history_reg[29:0], predict_taken};
            end
            // Update the history register on branch misprediction
            else if (train_mispredicted) begin
                history_reg <= {train_history, train_taken};
            end
        end
    end

    // Assign the value of the history register to the output
    assign predict_history = history_reg;

endmodule
