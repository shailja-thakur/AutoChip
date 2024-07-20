module gshare_predictor(
    input clk,
    input reset,
    input predict_valid,
    input [6:0] predict_pc,
    output reg predict_taken,
    output [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);

    reg [6:0] global_history;
    reg [6:0] pht_index;
    reg [1:0] pht_state [127:0];
    reg [1:0] predict_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            global_history <= 0;
            pht_index <= 0;
            pht_state <= 2'b00;
        end else begin
            if (train_valid) begin
                pht_state[pht_index] <= train_taken ? (pht_state[pht_index] == 2'b11 ? pht_state[pht_index] : pht_state[pht_index] + 1) : (pht_state[pht_index] == 2'b00 ? pht_state[pht_index] : pht_state[pht_index] - 1);
                global_history <= {global_history[5:0], train_taken};
            end
            if (predict_valid) begin
                predict_taken <= (pht_state[pht_index] == 2'b11 || pht_state[pht_index] == 2'b10);
                predict_history <= global_history;
                predict_state <= pht_state[pht_index];
                pht_index <= {global_history[6:1], predict_pc[0]} ^ predict_pc[1:0];
            end
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pht_state <= 2'b00;
        end else begin
            if (train_valid && train_mispredicted) begin
                pht_state <= pht_state;
            end
        end
    end

endmodule
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

    wire predict_taken;
    wire [6:0] predict_history;

    gshare_predictor predictor(
        .clk(clk),
        .reset(areset),
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
