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
reg [1:0] table [0:127];

always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 0;
    end else if (predict_valid) begin
        index <= predict_pc ^ global_history;
        predict_taken <= (table[index] == 3) ? 1'b1 : 1'b0;
        predict_history <= global_history;
    end else if (train_valid) begin
        global_history <= train_history;
        if (train_mispredicted) begin
            global_history <= train_history;
            index <= train_pc ^ global_history;
            table[index] <= (train_taken) ? table[index] + 1 : table[index] - 1;
        end
    end
end

endmodule
