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
reg [3:0] pattern;

localparam [3:0] IDLE = 0, DETECT_START = 1, DETECT_DELAY = 2, COUNT = 3, WAIT_ACK = 4;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        pattern <= 0;
        delay <= 0;
        counter <= 0;
        counting <= 0;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (data) pattern <= {pattern[2:0], data};
                if (pattern == 4'b1101) begin
                    state <= DETECT_DELAY;
                end
            end
            DETECT_DELAY: begin
                if (data) delay <= {delay[2:0], data};
                if (delay != 0) begin
                    state <= COUNT;
                    counting <= 1;
                end
            end
            COUNT: begin
                counter <= counter + 1;
                if (counter == (delay + 1) * 250) begin // 1000 cycles per delay increment
                    if (delay == 0) begin
                        state <= WAIT_ACK;
                        counting <= 0;
                        done <= 1;
                    end else begin
                        delay <= delay - 1;
                        counter <= 0;
                    end
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    state <= IDLE;
                    pattern <= 0;
                    delay <= 0;
                    counter <= 0;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = delay;

endmodule
