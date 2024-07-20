module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    reg [1:0] state;
    parameter IDLE = 2'd0, DETECT_1 = 2'd1, DETECT_10 = 2'd2, DETECT_101 = 2'd3;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            start_shifting <= 1'b0;
        end
        else begin
            case (state)
                IDLE: begin
                    if (data == 1'b1) begin
                        state <= DETECT_1;
                    end
                    else begin
                        state <= IDLE;
                    end
                    start_shifting <= 1'b0;
                end
                DETECT_1: begin
                    if (data == 1'b1) begin
                        state <= DETECT_10;
                    end
                    else begin
                        state <= IDLE;
                    end
                    start_shifting <= 1'b0;
                end
                DETECT_10: begin
                    if (data == 1'b0) begin
                        state <= DETECT_101;
                    end
                    else begin
                        state <= IDLE;
                    end
                    start_shifting <= 1'b0;
                end
                DETECT_101: begin
                    if (data == 1'b1) begin
                        state <= IDLE;
                        start_shifting <= 1'b1;
                    end
                    else begin
                        state <= IDLE;
                        start_shifting <= 1'b0;
                    end
                end
                default: begin
                    state <= IDLE;
                    start_shifting <= 1'b0;
                end
            endcase
        end
    end

endmodule
