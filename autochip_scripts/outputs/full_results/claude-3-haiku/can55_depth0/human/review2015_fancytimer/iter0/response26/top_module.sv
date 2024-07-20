module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

reg [3:0] delay;
reg [3:0] counter;
reg [3:0] state;
parameter IDLE = 4'd0, DETECT_PATTERN = 4'd1, CAPTURE_DELAY = 4'd2, COUNT_DOWN = 4'd3, WAIT_FOR_ACK = 4'd4;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        counting <= 1'b0;
        done <= 1'b0;
        delay <= 4'd0;
        counter <= 4'd0;
    end
    else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    state <= DETECT_PATTERN;
                end
                else begin
                    state <= IDLE;
                end
                counting <= 1'b0;
                done <= 1'b0;
            end
            DETECT_PATTERN: begin
                if ({data, data, data, data} == 4'b1101) begin
                    state <= CAPTURE_DELAY;
                end
                else if (data == 1'b0) begin
                    state <= IDLE;
                end
                else begin
                    state <= DETECT_PATTERN;
                end
            end
            CAPTURE_DELAY: begin
                delay <= {data, data, data, data};
                state <= COUNT_DOWN;
                counting <= 1'b1;
            end
            COUNT_DOWN: begin
                if (counter == 0) begin
                    if (delay == 0) begin
                        state <= WAIT_FOR_ACK;
                        done <= 1'b1;
                        counting <= 1'b0;
                    end
                    else begin
                        delay <= delay - 1;
                        counter <= delay + 1;
                    end
                end
                else begin
                    counter <= counter - 1;
                end
            end
            WAIT_FOR_ACK: begin
                if (ack) begin
                    state <= IDLE;
                end
                else begin
                    state <= WAIT_FOR_ACK;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

assign count = (state == COUNT_DOWN) ? delay : 4'bxxxx;

endmodule
