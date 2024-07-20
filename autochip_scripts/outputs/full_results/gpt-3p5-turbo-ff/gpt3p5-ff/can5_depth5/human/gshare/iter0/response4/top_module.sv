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
    reg [6:0] branch_history_register;    // branch history register

    // PHT (Pattern History Table)
    reg [1:0] pht_table [0:127];

    // GShare Branch Predictor
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            branch_history_register <= 0;
        end else begin
            if (predict_valid) begin
                predict_taken <= pht_table[predict_pc ^ branch_history_register];
                predict_history <= branch_history_register;
            end
            if (train_valid) begin
                pht_table[train_pc ^ train_history] <=
                    train_mispredicted ? (pht_table[train_pc ^ train_history] == 0 ? 0 : pht_table[train_pc ^ train_history] - 1) :
                    (pht_table[train_pc ^ train_history] == 3 ? 3 : pht_table[train_pc ^ train_history] + 1);
                
                branch_history_register <= train_history;
            end
        end
    end
endmodule
