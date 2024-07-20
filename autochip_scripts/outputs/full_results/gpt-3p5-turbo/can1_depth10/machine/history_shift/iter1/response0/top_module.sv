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

// Register to store the state
reg [31:0] predict_history_reg;

// Always block to check the clock and reset signals
always @(posedge clk or posedge areset)
    if (areset)
        predict_history_reg <= 0;
    else
        if (train_mispredicted)
            predict_history_reg <= {train_taken, predict_history_reg[31:1]};
        else if (predict_valid)
            predict_history_reg <= {predict_taken, predict_history_reg[31:1]};
            
// Assign the output
assign predict_history = predict_history_reg;

endmodule
