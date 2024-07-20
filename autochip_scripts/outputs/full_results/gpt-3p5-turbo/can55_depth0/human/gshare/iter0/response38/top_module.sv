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
reg [6:0] pht_index;
reg [1:0] pht_state[0:127];

always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 0;
        pht_index <= 0;
        pht_state <= 0;
    end else begin
        if (train_valid) begin
            pht_index <= train_pc ^ global_history;
            pht_state[pht_index] <= pht_state[pht_index] + (train_taken ? 1 : -1);
            global_history <= {global_history[5:0], train_taken};
        end else if (predict_valid) begin
            pht_index <= predict_pc ^ global_history;
            predict_taken <= (pht_state[pht_index] >= 2);
            predict_history <= global_history;
        end
    end
end

endmodule
