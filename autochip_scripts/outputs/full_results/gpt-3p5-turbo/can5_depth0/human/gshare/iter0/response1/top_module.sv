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

reg [2:0] pht [0:127];
reg [6:0] ghr;
reg predict_taken;
reg [6:0] predict_history;

always @(posedge clk or posedge areset) begin
    if (areset)
        ghr <= 7'b0;
    else
        ghr <= {ghr[5:0], predict_taken};
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        for (integer i = 0; i < 128; i = i + 1)
            pht[i] <= 3'b0;
    end else if (train_valid) begin
        pht[train_pc ^ train_history] <=
            train_mispredicted ? pht[train_pc ^ train_history] + 2'd1 : pht[train_pc ^ train_history] - 2'd1;
    end else if (predict_valid) begin
        predict_taken <= pht[predict_pc ^ predict_history] > 1;
        predict_history <= ghr;
    end
end

assign predict_taken = 1'b0;
assign predict_history = 7'b0;

endmodule
