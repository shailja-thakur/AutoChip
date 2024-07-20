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

    reg [6:0] ghr_out;
    reg [6:0] pht_index_out;
    reg [1:0] pht_value_out;

    reg [1:0] pht_table [0:127];

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            ghr_out <= 0;
            pht_index_out <= 0;
            pht_value_out <= 0;
            predict_taken <= 0;
            predict_history <= 0;
        end else begin
            if (train_valid) begin
                reg [1:0] pht_value_train;
                
                pht_value_train = pht_table[train_pc ^ ghr_out];
                
                if (train_mispredicted) begin
                    if (pht_value_train != 2'b00)
                        pht_table[train_pc ^ ghr_out] <= pht_value_train - 1;
                    ghr_out <= train_history;
                end
                
                pht_index_out <= train_pc ^ ghr_out;
                pht_value_out <= pht_table[pht_index_out];
            end else if (predict_valid) begin
                pht_index_out <= predict_pc ^ ghr_out;
                predict_taken <= (pht_value_out == 2'b11) || (pht_value_out == 2'b10);
                predict_history <= ghr_out;
            end
        end
    end

    assign ghr = ghr_out;
    assign pht_index = pht_index_out;
    assign pht_value = pht_value_out;

endmodule
