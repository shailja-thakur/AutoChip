module top_module(
    input clk,
    input areset,

    input predict_valid,
    input [6:0] predict_pc,
   -output reg predict_taken,
   -output reg [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);
    reg [6:0] ghr;
    reg [6:0] pht_index;
    reg [1:0] pht_value;
    reg [1:0] train_value;

    reg [1:0] pht_table [0:127];

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            ghr <= 0;
            pht_index <= 0;
            pht_value <= 0;
            train_value <= 0;
            predict_taken <= 0;
            predict_history <= 0;
        end else begin
            if (train_valid) begin
                pht_index <= train_pc ^ ghr;
                
                if (train_mispredicted) begin
                    pht_table[pht_index] <= pht_value - 1;
                    ghr <= {train_history[5:0], train_taken};
                end
                
                train_value <= pht_table[pht_index];
                pht_table[pht_index] <= train_taken ? $signed(train_value) < 3 : $signed(train_value) > 0;
            end else if (predict_valid) begin
                pht_index <= predict_pc ^ ghr;
                predict_taken <= (pht_table[pht_index] == 3) || (pht_table[pht_index] == 2);
                predict_history <= ghr;
            end
        end
    end

endmodule
