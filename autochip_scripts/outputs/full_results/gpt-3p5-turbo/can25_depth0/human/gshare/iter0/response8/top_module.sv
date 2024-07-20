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
reg [6:0] next_global_history;
reg [6:0] predicted_pc;
reg predict_taken;
reg [6:0] predicted_history;

reg [6:0] index;
reg [1:0] pht[0:127];
reg [1:0] next_pht[0:127];

assign predict_taken = pht[index] > 1;
assign predict_history = predicted_history;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 0;
        next_global_history <= 0;
        predict_taken <= 0;
        predicted_history <= 0;
        index <= 0;

        for (int i = 0; i < 128; i = i + 1) begin
            pht[i] <= 0;
            next_pht[i] <= 0;
        end
    end
    else begin
        global_history <= next_global_history;
        index <= global_history ^ predict_pc;
        predicted_pc <= predict_pc;
        predicted_history <= global_history;

        if (train_valid && train_pc != predicted_pc) begin
            next_global_history <= global_history;
            next_pht[index] <= pht[index];
        end else begin
            next_global_history <= global_history << 1 | train_taken;
            next_pht[index] <= pht[index] + (train_taken == predict_taken ? 1 : -1);
        end
    end
end

assign predict_taken = pht[index] > 1;
assign predict_history = global_history;

endmodule
