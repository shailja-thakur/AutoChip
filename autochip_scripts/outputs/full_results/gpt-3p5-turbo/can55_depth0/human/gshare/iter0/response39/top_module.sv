module top_module(
    input clk,
    input areset, 

    input predict_valid,
    input [6:0] predict_pc,
    output reg predict_taken, 
    output reg [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history, 
    input [6:0] train_pc
);

reg [127:0] pht_table; // Pattern History Table
reg [6:0] branch_history_register;
wire [6:0] pht_index; // Index for the Pattern History Table

reg [1:0] predict_state; // Saturating counter for the predicted branch

assign pht_index = predict_pc ^ branch_history_register;

always @(posedge clk or posedge areset) begin
    if (areset)
        branch_history_register <= 0;
    else if (train_valid) begin
        branch_history_register <= train_history;
        pht_table[pht_index] <= pht_table[pht_index] + train_taken;
        if (train_mispredicted)
            branch_history_register <= train_history;
    end else if (predict_valid)
        predict_history <= branch_history_register;
end

always @(posedge clk or posedge areset) begin
    if (areset)
        predict_state <= 0;
    else if (predict_valid)
        predict_taken <= (pht_table[pht_index] >= 2);
end

endmodule
