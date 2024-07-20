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

reg [6:0] global_history;
reg [6:0] index;
reg [1:0] pht [0:127];

always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 7'b0;
    end else if (train_valid) begin
        global_history <= {global_history[5:0], train_taken};
    end else if (predict_valid) begin
        index <= predict_pc ^ global_history;
        predict_taken <= pht[index][1];
        predict_history <= global_history;
    end
end

always @(posedge clk) begin
    if (train_valid) begin
        index <= train_pc ^ train_history;
        if (train_mispredicted) begin
            pht[index] <= $past(pht[index]);
            global_history <= train_history;
        end else begin
            pht[index] <= $past(pht[index]) + train_taken;
            global_history <= {global_history[5:0], train_taken};
        end
    end
end

endmodule
