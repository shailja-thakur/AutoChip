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

    parameter ADDR_WIDTH = 7;
    parameter HISTORY_LENGTH = 7;
    parameter INDEX_WIDTH = 7;
    parameter PHT_ENTRY_WIDTH = 2;
    parameter PHT_SIZE = 2 ** INDEX_WIDTH;
    parameter PHT_HISTORY_MASK = (2 ** HISTORY_LENGTH) - 1;
    parameter GHR_INIT_VALUE = 0;
    
    reg [ADDR_WIDTH - 1:0] ghr;
    reg [INDEX_WIDTH - 1:0] pht_index;
    reg [PHT_ENTRY_WIDTH - 1:0] pht_value;
    
    reg [PHT_ENTRY_WIDTH - 1:0] pht_table [0:PHT_SIZE-1];

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            ghr <= GHR_INIT_VALUE;
            pht_index <= 0;
            pht_value <= 0;
            predict_taken <= 0;
            predict_history <= 0;
        end else begin
            if (train_valid) begin
                pht_index <= {train_pc, ghr[HISTORY_LENGTH-1:0]} ^ train_history;
                if (train_mispredicted) begin
                    pht_table[pht_index] <= pht_value - 1;
                    ghr <= {ghr[HISTORY_LENGTH-1:0], train_taken};
                end
                pht_value <= pht_table[pht_index];
            end else if (predict_valid) begin
                pht_index <= {predict_pc, ghr[HISTORY_LENGTH-1:0]};
                predict_taken <= (pht_value == 2'b11) || (pht_value == 2'b10);
                predict_history <= {ghr[HISTORY_LENGTH-1:0], predict_taken};
            end
        end
    end
    
endmodule
