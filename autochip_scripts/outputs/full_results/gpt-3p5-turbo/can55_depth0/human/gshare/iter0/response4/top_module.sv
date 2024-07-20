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

reg [6:0] history_register;
reg [6:0] index;
reg [1:0] pht [127:0];

always @(posedge clk or posedge areset) begin
    if (areset) begin
        history_register <= 0;
        pht <= 2'b00;
    end else begin
        if (train_valid) begin
            pht[index] <= train_mispredicted ? pht[index] - 1 : pht[index] + 1;
            history_register <= train_history;
        end else if (predict_valid) begin
            index <= predict_pc ^ history_register;
        end
    end
end

assign predict_taken = pht[index][1];
assign predict_history = history_register;

endmodule
