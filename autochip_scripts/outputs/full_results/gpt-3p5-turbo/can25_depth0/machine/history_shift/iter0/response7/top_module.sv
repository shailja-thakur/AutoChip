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

// Registers for prediction history and training history
logic [31:0] predict_history_reg;
logic [31:0] train_history_reg;

always @(posedge clk or posedge areset)
begin
    if (areset)
        predict_history_reg <= 0;
    else
    begin
        if (train_mispredicted)
            predict_history_reg <= {predict_history_reg[30:0], train_taken};
        else if (predict_valid)
            predict_history_reg <= {predict_history_reg[30:0], predict_taken};
    end
end

// Output prediction history
assign predict_history = predict_history_reg;

endmodule
