module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

reg [1:0] state;
parameter [1:0] IDLE = 2'b00, DETECT_1 = 2'b01, DETECT_10 = 2'b10, DETECT_101 = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        start_shifting <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (data == 1'b1)
                    state <= DETECT_1;
                else
                    state <= IDLE;
                start_shifting <= 1'b0;
            end
            DETECT_1: begin
                if (data == 1'b1)
                    state <= DETECT_1;
                else if (data == 1'b0)
                    state <= DETECT_10;
                else
                    state <= IDLE;
                start_shifting <= 1'b0;
            end
            DETECT_10: begin
                if (data == 1'b1)
                    state <= DETECT_101;
                else
                    state <= IDLE;
                start_shifting <= 1'b0;
            end
            DETECT_101: begin
                if (data == 1'b1)
                    state <= DETECT_1;
                else
                    state <= IDLE;
                start_shifting <= 1'b1;
            end
            default: begin
                state <= IDLE;
                start_shifting <= 1'b0;
            end
        endcase
    end
end

endmodule
