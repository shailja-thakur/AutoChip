module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    localparam STATE_IDLE = 4'd0;
    localparam STATE_FOUND_1 = 4'd1;
    localparam STATE_FOUND_10 = 4'd2;
    localparam STATE_FOUND_101 = 4'd3;
    localparam STATE_FOUND_1101 = 4'd4;

    reg [3:0] state;

    always @(posedge clk) begin
        if (reset) begin
            state <= STATE_IDLE;
            start_shifting <= 1'b0;
        end
        else begin
            case (state)
                STATE_IDLE: begin
                    if (data == 1'b1) begin
                        state <= STATE_FOUND_1;
                    end
                    else begin
                        state <= STATE_IDLE;
                    end
                    start_shifting <= 1'b0;
                end
                STATE_FOUND_1: begin
                    if (data == 1'b0) begin
                        state <= STATE_FOUND_10;
                    end
                    else begin
                        state <= STATE_FOUND_1;
                    end
                    start_shifting <= 1'b0;
                end
                STATE_FOUND_10: begin
                    if (data == 1'b1) begin
                        state <= STATE_FOUND_101;
                    end
                    else begin
                        state <= STATE_IDLE;
                    end
                    start_shifting <= 1'b0;
                end
                STATE_FOUND_101: begin
                    if (data == 1'b0) begin
                        state <= STATE_FOUND_1101;
                    end
                    else begin
                        state <= STATE_IDLE;
                    end
                    start_shifting <= 1'b0;
                end
                STATE_FOUND_1101: begin
                    state <= STATE_FOUND_1101;
                    start_shifting <= 1'b1;
                end
                default: begin
                    state <= STATE_IDLE;
                    start_shifting <= 1'b0;
                end
            endcase
        end
    end

endmodule
