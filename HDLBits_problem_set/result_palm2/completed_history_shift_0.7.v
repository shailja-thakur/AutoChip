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
    reg [31:0] history;
    reg [1:0] state;

    always @(posedge clk) begin
        if (areset) begin
            predict_history <= 32'h0;
            train_history <= 32'h0;
            history <= 32'h0;
            state <= 0;
        end else begin
            if (predict_valid) begin
                if (predict_taken) begin
                    history <= history << 1;
                    history[0] <= predict_taken;
                else begin
                    history <= history << 1;
                end
            end else if (train_mispredicted) begin
                history <= train_history;
                history[0] <= train_taken;
                state <= 1;
            end
        end
        predict_history <= history;
    end

    assign predict_history = state == 0 ? predict_history : train_history;

endmodule