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

reg [6:0] history;
reg [6:0] index;
reg [1:0] counters [0:127];

always@(posedge clk or posedge areset) begin
    if (areset) begin
        history <= 0;
        index <= 0;
        counters <= 2'b00;
        predict_taken <= 0;
        predict_history <= 0;
    end else begin
        if (predict_valid) begin
            index <= predict_pc ^ history;
            predict_taken <= counters[index][1];
            predict_history <= history;
        end
        if (train_valid) begin
            index <= train_pc ^ train_history;
            counters[index][train_taken] <= counters[index][train_taken] + 1;
        end
        if (train_mispredicted) begin
            history <= train_history;
        end
    end
end

endmodule
