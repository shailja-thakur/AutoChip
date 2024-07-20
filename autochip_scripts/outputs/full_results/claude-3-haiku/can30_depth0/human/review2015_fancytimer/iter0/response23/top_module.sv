module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam WAIT_START = 0, WAIT_DURATION = 1, COUNT_DELAY = 2, WAIT_ACK = 3;
reg [1:0] state;
reg [3:0] pattern;
reg [3:0] delay;
reg [13:0] counter;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        pattern <= 4'b0;
        delay <= 4'b0;
        counter <= 0;
        counting <= 0;
        done <= 0;
    end else begin
        case (state)
            WAIT_START: begin
                if (pattern == 4'b1101) begin
                    state <= WAIT_DURATION;
                    pattern <= 4'b0;
                end else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            WAIT_DURATION: begin
                if (pattern == 4'b1111) begin
                    state <= COUNT_DELAY;
                    delay <= pattern[3:0];
                    counter <= 0;
                    counting <= 1;
                end else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            COUNT_DELAY: begin
                if (counter == (delay + 1) * 1000 - 1) begin
                    state <= WAIT_ACK;
                    counting <= 0;
                    done <= 1;
                end else begin
                    counter <= counter + 1;
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    state <= WAIT_START;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = (state == COUNT_DELAY) ? (delay - counter / 1000) : 4'bx;

endmodule
