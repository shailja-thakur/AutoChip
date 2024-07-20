module gshare_branch_predictor (
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
    reg [1:0] counter [0:127];

    always @(posedge clk or posedge areset) begin
        if (areset)
            global_history <= 0;
        else if (predict_valid) begin
            index <= predict_pc ^ global_history;
            predict_history <= global_history;
            predict_taken <= counter[index] > 1;
        end else if (train_valid) begin
            index <= train_pc ^ train_history;
            if (train_mispredicted) begin
                counter[index] <= (counter[index] == 0) ? 0 : counter[index] - 1;
                global_history <= train_history;
            end else if (train_taken)
                counter[index] <= (counter[index] == 3) ? 3 : counter[index] + 1;
        end
    end

endmodule
module top_module (
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
    
    gshare_branch_predictor gshare_bp (
        .clk(clk),
        .areset(areset),
        .predict_valid(predict_valid),
        .predict_pc(predict_pc),
        .predict_taken(predict_taken),
        .predict_history(predict_history),
        .train_valid(train_valid),
        .train_taken(train_taken),
        .train_mispredicted(train_mispredicted),
        .train_history(train_history),
        .train_pc(train_pc)
    );

endmodule
