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
    reg [6:0] ghr;
    reg [6:0] pht_index;
    reg [1:0] pht_value;
    reg [1:0] pht_value_next;
    reg [1:0] train_pht_value;
    reg [6:0] train_pht_index;

    reg [1:0] pht_table [0:127];

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            ghr <= 0;
            pht_index <= 0;
            pht_value <= 0;
            pht_value_next <= 0;
            predict_taken <= 0;
            predict_history <= 0;
        end else begin
            if (train_valid) begin
                pht_index <= train_pc ^ ghr;
                train_pht_index <= train_pc ^ ghr;
                if (train_mispredicted) begin
                    pht_table[train_pht_index] <= train_pht_value - 1;
                    ghr <= {train_history[5:0], train_taken};
                end
                pht_value <= pht_table[train_pht_index];
                pht_value_next <= pht_value;
                train_pht_value <= pht_value_next;
                pht_value <= pht_value_next;
            end else if (predict_valid) begin
                pht_index <= predict_pc ^ ghr;
                predict_taken <= (pht_value[1] == 1) || (pht_value[0] == 1);
                predict_history <= ghr;
            end
        end
    end

endmodule
