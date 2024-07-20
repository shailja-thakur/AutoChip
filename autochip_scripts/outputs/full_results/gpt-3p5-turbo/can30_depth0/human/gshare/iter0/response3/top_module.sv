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

    reg [6:0] pc;
    reg [6:0] history;
    reg predict_taken;
    reg [6:0] predict_history;

    reg [6:0] pht_index;
    reg [127:0] pht_table;
    reg [1:0] pht_state;
    reg [6:0] train_pc_reg;
    reg [6:0] train_history_reg;
    reg train_taken_reg;
    reg train_mispredicted_reg;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            pc <= 0;
            history <= 0;
            pht_index <= 0;
            pht_table <= 0;
            pht_state <= 0;
            train_pc_reg <= 0;
            train_history_reg <= 0;
            train_taken_reg <= 0;
            train_mispredicted_reg <= 0;
            predict_taken <= 0;
            predict_history <= 0;
        end else begin
            if (predict_valid) begin
                pc <= predict_pc;
                history <= predict_history;
                pht_index <= (predict_pc ^ predict_history) & 7'b0111111;
                pht_state <= pht_table[pht_index*2 +: 2];
                predict_taken <= pht_state[1];
                predict_history <= history;
            end
            
            if (train_valid) begin
                train_pc_reg <= train_pc;
                train_history_reg <= train_history;
                train_taken_reg <= train_taken;
                train_mispredicted_reg <= train_mispredicted;
                pht_index <= (train_pc ^ train_history) & 7'b0111111;
                
                if (train_mispredicted_reg) begin
                    pht_table[pht_index*2 +: 2] <= pht_state-d-1;
                end else begin
                    pht_table[pht_index*2 +: 2] <= pht_state+d+1;
                end
                
                history <= train_history_reg;
            end
        end
    end

endmodule
