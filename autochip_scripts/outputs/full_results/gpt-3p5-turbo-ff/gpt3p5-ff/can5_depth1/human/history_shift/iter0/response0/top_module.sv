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

    reg [31:0] history_reg; // 32-bit global history shift register
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            history_reg <= 0; // Reset history register to zero
        end else begin
            if (train_mispredicted) begin
                history_reg <= {train_history, train_taken}; // Load history register with history after mispredicted branch
            end else if (predict_valid) begin
                history_reg <= {history_reg[30:0], predict_taken}; // Shift in predict_taken from LSB side to update history register
            end
        end
    end
    
    assign predict_history = history_reg;
    
endmodule
