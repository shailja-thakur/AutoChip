module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam STATE_WAIT = 0;
localparam STATE_SHIFT = 1;
localparam STATE_COUNT = 2;
localparam STATE_DONE = 3;

reg [1:0] state;
reg [3:0] pattern;
reg [3:0] delay;
reg [15:0] counter;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT;
        counting <= 0;
        done <= 0;
        pattern <= 0;
        delay <= 0;
        counter <= 0;
    end else begin
        case (state)
            STATE_WAIT: begin
                // Wait for input pattern 1101
                pattern <= {pattern[2:0], data};
                if (pattern == 4'b1101) begin
                    state <= STATE_SHIFT;
                end
            end
            STATE_SHIFT: begin
                // Shift in 4 bits for delay
                delay <= {delay[2:0], data};
                if (delay[3]) begin
                    state <= STATE_COUNT;
                    counting <= 1;
                    counter <= 0;
                end
            end
            STATE_COUNT: begin
                // Count down the delay
                counter <= counter + 1;
                if (counter == (delay + 1) * 1000 - 1) begin
                    state <= STATE_DONE;
                    counting <= 0;
                    done <= 1;
                end
            end
            STATE_DONE: begin
                // Wait for acknowledge
                if (ack) begin
                    state <= STATE_WAIT;
                    done <= 0;
                end
            end
            default: begin
                state <= STATE_WAIT;
            end
        endcase
    end
end

assign count = delay - (counter / 1000);

endmodule
