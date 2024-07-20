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

    reg [6:0] global_history;
    reg [6:0] pht_index;
    reg [127:0] pht;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 0;
            pht_index <= 0;
            pht <= 0;
        end else begin
            if (predict_valid) begin
                predict_taken <= pht[pht_index] >= 2;
                predict_history <= global_history;
            end
            
            if (train_valid) begin
                pht[pht_index] <= pht[pht_index] + (train_taken ? 1 : -1);
                if (train_mispredicted) begin
                    global_history <= train_history;
                end
            end
        end
    end

    always @(posedge clk) begin
        if (predict_valid) begin
            pht_index <= predict_pc ^ global_history;
        end
    end
    
endmodule
