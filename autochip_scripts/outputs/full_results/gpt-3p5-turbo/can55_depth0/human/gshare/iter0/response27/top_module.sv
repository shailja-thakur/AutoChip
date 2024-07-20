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

reg [6:0] pht_index;
reg [1:0] pht_state [0:127];
reg [6:0] bhr;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        pht_index <= 0;
        pht_state <= 2'b00;
        bhr <= 0;
    end else begin
        if (train_valid) begin
            pht_state[train_pc] <= (train_taken) ? pht_state[train_pc] + 1 : pht_state[train_pc] - 1;
            if (train_mispredicted)
                bhr <= train_history;
        end else begin
            pht_index <= {predict_pc[6:0], bhr[6:0]} ^ 7'b1111111;
            predict_taken <= (pht_state[pht_index] > 1);
            predict_history <= bhr;
        end
    end
end

endmodule
