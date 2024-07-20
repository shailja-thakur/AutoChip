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

reg [6:0] branch_history_register;
reg predict_taken;
reg [6:0] predict_history;

reg [6:0] branch_index;
reg [1:0] branch_prediction;
reg [1:0] pht_table[127:0];
reg train_misprediction;
reg [6:0] train_pc_prev;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        branch_history_register <= 7'b0;
    end else begin
        if (predict_valid) begin
            branch_index <= predict_pc ^ branch_history_register;
            branch_prediction <= pht_table[branch_index];
            predict_taken <= (branch_prediction[1] == 2'b11) || (branch_prediction[1] == 2'b10);
            predict_history <= branch_history_register;
        end

        if (train_valid) begin
            branch_index <= train_pc ^ train_history;
            train_misprediction <= (train_taken != branch_prediction[1]);
            pht_table[branch_index] <= train_misprediction ? branch_prediction - train_misprediction: branch_prediction + train_taken;
            branch_history_register <= train_history;
            train_pc_prev <= train_pc;
        end elseif (predict_taken && (train_misprediction || (predict_valid && (train_pc == train_pc_prev)))) begin
            branch_history_register <= train_history;
        end
    end
end

endmodule
