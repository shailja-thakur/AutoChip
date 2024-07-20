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
    
    logic [31:0] history_shift_reg;

    always @(posedge clk or posedge areset) begin
        if (areset)
            history_shift_reg <= 0;
        else if (train_mispredicted)
            history_shift_reg <= {train_history[30:0], train_taken};
        else if (predict_valid)
            history_shift_reg <= {history_shift_reg[30:0], predict_taken};
    end

    assign predict_history = history_shift_reg;
  
endmodule
