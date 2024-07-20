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

    logic [31:0] history_reg;    // 32-bit global history shift register
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            history_reg <= 0;    // Reset the history counter to zero
        end else begin
            if (train_mispredicted) begin
                history_reg <= {train_history[30:0], train_taken};    // Load the branch history register with history after the completion of the mispredicted branch
            end else if (predict_valid) begin
                history_reg <= {history_reg[30:0], predict_taken};    // Update the branch history for the predicted branch
            end
        end
    end
    
    assign predict_history = history_reg;

endmodule
