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
    
    logic [31:0] shift_reg;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            shift_reg <= 0;
        else if (train_mispredicted)
            shift_reg <= {train_history, train_taken};
        else if (predict_valid)
            shift_reg <= {shift_reg[30:0], predict_taken};
    end
    
    assign predict_history = shift_reg;
    
endmodule
