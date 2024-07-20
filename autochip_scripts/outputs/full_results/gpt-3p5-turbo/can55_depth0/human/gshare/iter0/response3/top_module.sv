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
    reg [1:0] pht_value[0:127];
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            ghr <= 0;
            pht_index <= 0;
            for (int i = 0; i < 128; i = i + 1) begin
                pht_value[i] <= 0;
            end
        end else begin
            if (predict_valid) begin
                predict_history <= ghr;
                pht_index <= predict_pc ^ ghr;
                predict_taken <= (pht_value[pht_index] == 2) ? 1 : 0;
            end
            
            if (train_valid) begin
                pht_index <= train_pc ^ train_history;
                
                if (train_mispredicted) begin
                    ghr <= train_taken ? (ghr << 1) | 1 : (ghr << 1) | 0;
                end
                
                if (train_taken) begin
                    pht_value[pht_index] <= (pht_value[pht_index] < 3) ? pht_value[pht_index] + 1 : pht_value[pht_index];
                else begin
                    pht_value[pht_index] <= (pht_value[pht_index] > 0) ? pht_value[pht_index] - 1 : pht_value[pht_index];
                end
            end
        end
    end
    
endmodule
