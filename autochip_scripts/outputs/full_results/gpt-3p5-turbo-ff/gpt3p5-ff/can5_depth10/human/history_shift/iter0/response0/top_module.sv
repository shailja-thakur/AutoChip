module top_module (
    input clk,
    input areset,
    input predict_valid,
    input predict_taken,
    output logic [31:0] predict_history,
    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);
    reg [31:0] history_shift_reg; // 32-bit global history shift register
    
    always @(posedge clk or posedge areset)
    begin
        if (areset)
            history_shift_reg <= 0; // Asynchronous reset, reset history to zero
        else if (train_mispredicted)
            history_shift_reg <= {train_history, train_taken}; // Load shift register with history after mispredicted branch
        else if (predict_valid)
            history_shift_reg <= {history_shift_reg[30:0], predict_taken}; // Shift in predict_taken to update branch history
    end
    
    assign predict_history = history_shift_reg; // Output the branch history register
    
endmodule
