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

reg [6:0] branch_history_register;
reg [6:0] prediction_index;
reg [6:0] train_index;
reg [1:0] pht [0:127];
reg predict_taken_reg;
reg [6:0] predict_history_reg;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        branch_history_register <= 0;
    end else if (predict_valid) begin
        prediction_index <= predict_pc ^ branch_history_register;
        predict_taken_reg <= pht[prediction_index][1];
        predict_history_reg <= branch_history_register;
    end else if (train_valid) begin
        train_index <= train_pc ^ train_history;
        pht[train_index][train_taken] <= pht[train_index][train_taken] + (train_mispredicted ? -1 : 1);
        branch_history_register <= {branch_history_register[5:0], train_taken};
    end
end

assign predict_taken = predict_taken_reg;
assign predict_history = predict_history_reg;

endmodule
