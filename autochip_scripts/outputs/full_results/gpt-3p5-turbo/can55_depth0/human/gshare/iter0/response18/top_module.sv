module gshare_predictor(
    input                                        clk,
    input                                        areset,

    input                                        valid_predict,
    input  [6:0]                                 pc_predict,
    output                                       direction_predict,
    output [6:0]                                 history_predict,

    input                                        valid_train,
    input                                        taken_train,
    input                                        mispredicted_train,
    input  [6:0]                                 history_train,
    input  [6:0]                                 pc_train,
    output reg [127:0]                           pht,
    output reg [6:0]                             history_register
);
reg [6:0] index_predict;
reg        direction;
reg [6:0] index_train;

always@(posedge clk or posedge areset) begin
    if (areset) begin
        index_predict <= 0;
        direction <= 0;
        index_train <= 0;
        pht <= 0;
        history_register <= 0;
    end else begin
        if (valid_predict) begin
            index_predict <= {pc_predict[6:0], history_register[6:0]} ^ index_predict;
            direction <= pht[index_predict][1];
        end
        if (valid_train) begin
            index_train <= {pc_train[6:0], history_train[6:0]} ^ index_train;
            if (mispredicted_train) begin
                pht[index_train] <= pht[index_train][1:0] - 1;
                history_register <= train_history;
            end else begin
                pht[index_train] <= pht[index_train][1:0] + 1;
            end
        end
    end
end

assign direction_predict = direction;
assign history_predict = history_register;

endmodule
module top_module(
    input                                        clk,
    input                                        areset,

    input                                        predict_valid,
    input  [6:0]                                 predict_pc,
    output                                       predict_taken,
    output [6:0]                                 predict_history,

    input                                        train_valid,
    input                                        train_taken,
    input                                        train_mispredicted,
    input  [6:0]                                 train_history,
    input  [6:0]                                 train_pc
);
wire                                        direction_predict;
wire [6:0]                                 history_predict;

reg [6:0] global_history_register;
wire [6:0] index;

gshare_predictor predictor(
    .clk(clk),
    .areset(areset),
    .valid_predict(predict_valid),
    .pc_predict(predict_pc),
    .direction_predict(direction_predict),
    .history_predict(history_predict),
    .valid_train(train_valid),
    .taken_train(train_taken),
    .mispredicted_train(train_mispredicted),
    .history_train(train_history),
    .pc_train(train_pc),
    .pht(index),
    .history_register(global_history_register)
);

always @(posedge clk or posedge areset) begin
    if (areset) begin
        predict_taken <= 0;
        global_history_register <= 0;
    end else begin
        if (predict_valid) begin
            predict_taken <= direction_predict;
        end
        if (train_valid) begin
            global_history_register <= train_history;
        end
    end
end

assign predict_history = global_history_register;

endmodule
