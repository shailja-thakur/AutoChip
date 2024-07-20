module top_module(
    input clk,
    input areset,

    input predict_valid,
    input [6:0] predict_pc,
    output predict_taken,
    output [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);

    reg [2:0] pattern_history_table [0:127];
    reg [6:0] global_branch_history_register;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_branch_history_register <= 7'b0;
        end else if (predict_valid) begin
            predict_history <= global_branch_history_register;
            predict_taken <= pattern_history_table[predict_pc ^ global_branch_history_register];
        end else if (train_valid) begin
            pattern_history_table[train_pc ^ train_history] <= train_mispredicted ? (train_taken ? $unsigned(pattern_history_table[train_pc ^ train_history]) + 1 : $unsigned(pattern_history_table[train_pc ^ train_history]) - 1) : (train_taken ? $unsigned(pattern_history_table[train_pc ^ train_history]) + 1 : $unsigned(pattern_history_table[train_pc ^ train_history]));
            global_branch_history_register <= train_history;
        end
    end
endmodule
