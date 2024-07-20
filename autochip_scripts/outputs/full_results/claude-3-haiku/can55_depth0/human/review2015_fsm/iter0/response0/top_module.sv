module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack
);

reg [3:0] state;
reg [3:0] pattern;

localparam [3:0]
    WAIT_PATTERN = 0,
    SHIFT_DURATION = 1,
    WAIT_COUNTING = 2,
    NOTIFY_USER = 3;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_PATTERN;
        pattern <= 0;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end else begin
        case (state)
            WAIT_PATTERN: begin
                // Shift in new bit and update the pattern
                pattern <= {pattern[2:0], data};

                // Check if the pattern matches 1101
                if (pattern == 4'b1101) begin
                    state <= SHIFT_DURATION;
                    shift_ena <= 1;
                end else begin
                    shift_ena <= 0;
                end
            end

            SHIFT_DURATION: begin
                // Shift in 4 more bits
                if (shift_ena) begin
                    shift_ena <= (shift_ena) ? 1'b1 : 1'b0;
                end else begin
                    state <= WAIT_COUNTING;
                    counting <= 1;
                    shift_ena <= 0;
                end
            end

            WAIT_COUNTING: begin
                // Wait for the counters to finish
                if (done_counting) begin
                    state <= NOTIFY_USER;
                    counting <= 0;
                    done <= 1;
                end
            end

            NOTIFY_USER: begin
                // Wait for the user to acknowledge
                if (ack) begin
                    state <= WAIT_PATTERN;
                    done <= 0;
                end
            end

            default: begin
                state <= WAIT_PATTERN;
            end
        endcase
    end
end

endmodule
