module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam PATTERN_SIZE = 4;
localparam DELAY_SIZE = 4;

reg [PATTERN_SIZE-1:0] pattern;
reg [DELAY_SIZE-1:0] delay;
reg [DELAY_SIZE:0] counter;

parameter [2:0] STATE_SEARCH = 3'b000,
                STATE_CAPTURE_PATTERN = 3'b001,
                STATE_CAPTURE_DELAY = 3'b010,
                STATE_COUNTDOWN = 3'b011,
                STATE_DONE = 3'b100;

reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_SEARCH;
        pattern <= 0;
        delay <= 0;
        counter <= 0;
        counting <= 0;
        done <= 0;
    end else begin
        state <= next_state;

        case (state)
            STATE_SEARCH: begin
                if (data) begin
                    pattern <= {pattern[PATTERN_SIZE-2:0], data};
                    if (pattern == {PATTERN_SIZE{1'b1}}) begin
                        next_state <= STATE_CAPTURE_DELAY;
                        pattern <= 0;
                    end else begin
                        next_state <= STATE_SEARCH;
                    end
                end else begin
                    next_state <= STATE_SEARCH;
                end
            end

            STATE_CAPTURE_DELAY: begin
                if (data) begin
                    delay <= {delay[DELAY_SIZE-2:0], data};
                    if (delay == {DELAY_SIZE{1'b1}}) begin
                        next_state <= STATE_COUNTDOWN;
                        counter <= delay + 1;
                        counting <= 1;
                    end else begin
                        next_state <= STATE_CAPTURE_DELAY;
                    end
                end else begin
                    next_state <= STATE_CAPTURE_DELAY;
                end
            end

            STATE_COUNTDOWN: begin
                if (counter == 0) begin
                    next_state <= STATE_DONE;
                    counting <= 0;
                    done <= 1;
                end else begin
                    counter <= counter - 1;
                    next_state <= STATE_COUNTDOWN;
                end
            end

            STATE_DONE: begin
                if (ack) begin
                    next_state <= STATE_SEARCH;
                    done <= 0;
                end else begin
                    next_state <= STATE_DONE;
                end
            end
        endcase
    end
end

assign count = counter[DELAY_SIZE:1];

endmodule
