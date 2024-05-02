module top_module(
    input clk,
    input areset,

    input predict_valid,
    input predict_taken,
    output [31:0] predict_history,

    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);

    reg [31:0] predict_history;
    reg [31:0] train_history;
    reg [1:0] state;

    always @(posedge clk) begin
        if (areset) begin
            state <= 0;
        end else begin
            if (predict_valid) begin
                predict_history <= predict_history << 1;
                predict_history[0] <= predict_taken;
            end else if (train_mispredicted) begin
                predict_history <= train_history;
            end
        end
    end

    assign predict_history = state[1:0] ? predict_history : train_history;

endmodule