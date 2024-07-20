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

// register to store the branch prediction history
reg [31:0] predict_history_reg;

always @(posedge clk or posedge areset)
begin
    if (areset)
        predict_history_reg <= 0;
    else if (predict_valid)
        predict_history_reg <= predict_taken;
    else if (train_mispredicted)
        predict_history_reg <= {predict_history_reg[30:0], train_taken};
end

assign predict_history = predict_history_reg;

endmodule
