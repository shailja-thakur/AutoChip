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

reg [6:0] global_hist;
reg [6:0] index;
reg [1:0] pht[0:127];

always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_hist <= 0;
    end else if (train_valid) begin
        global_hist <= train_history;
        index <= train_pc ^ global_hist;
        if (train_mispredicted) begin
            pht[index] <= pht[index] - 1;
            global_hist <= train_history;
        end else begin
            pht[index] <= pht[index] + 1;
        end
    end else if (predict_valid) begin
        index <= predict_pc ^ global_hist;
        predict_taken <= pht[index] > 1;
        predict_history <= global_hist;
    end
end

endmodule
