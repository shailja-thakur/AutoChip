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

reg [1:0] table [0:127];
reg [6:0] global_history;

always @(posedge clk or posedge areset) begin
    if (areset)
        global_history <= 0;
    else if (train_valid)
        global_history <= {global_history[5:0], train_taken};
end

always @(*) begin
    if (predict_valid) begin
        predict_taken = table[predict_pc[6:0] ^ global_history[6:0]] > 1;
        predict_history = global_history;
    end
end

always @(posedge clk) begin
    if (train_valid) begin
        table[train_pc[6:0] ^ train_history[6:0]] <= table[train_pc[6:0] ^ train_history[6:0]] + (train_taken ? 1 : -1);
        if (train_mispredicted)
            global_history <= train_history;
    end
end

endmodule
