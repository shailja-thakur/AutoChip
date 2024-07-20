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
reg [6:0] index;
reg [1:0] pht [0:127];
reg predict_taken;
reg [6:0] predict_history;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 0;
        index <= 0;
        pht <= 0;
        predict_taken <= 0;
        predict_history <= 0;
    end else begin
        if (train_valid) begin
            index <= train_pc ^ train_history;
            if (train_mispredicted) begin
                global_history <= train_history ^ (1 << 6);
            end else begin
                global_history <= train_history;
            end
            pht[index] <= pht[index] + train_taken;
        end

        if (predict_valid) begin
            index <= predict_pc ^ global_history;
            predict_taken <= (pht[index] >= 2);
            predict_history <= global_history;
        end
    end
end

endmodule
