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
parameter [3:0] WAIT_PATTERN = 4'd0, SHIFT_DURATION = 4'd1, WAIT_COUNTING = 4'd2, NOTIFY_USER = 4'd3;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= WAIT_PATTERN;
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end
    else begin
        case (state)
            WAIT_PATTERN: begin
                // Wait for the 1101 pattern
                if (data == 1'b1 && data == 1'b1 && data == 1'b0 && data == 1'b1) begin
                    state <= SHIFT_DURATION;
                    shift_ena <= 1'b1;
                end
                else begin
                    shift_ena <= 1'b0;
                    counting <= 1'b0;
                    done <= 1'b0;
                end
            end

            SHIFT_DURATION: begin
                // Shift in 4 more bits to determine the duration
                if (shift_ena == 1'b1) begin
                    if (shift_ena == 1'b1) begin
                        shift_ena <= 1'b0;
                        state <= WAIT_COUNTING;
                        counting <= 1'b1;
                    end
                    else begin
                        shift_ena <= 1'b1;
                    end
                end
            end

            WAIT_COUNTING: begin
                // Wait for the counters to finish
                if (done_counting == 1'b1) begin
                    counting <= 1'b0;
                    state <= NOTIFY_USER;
                    done <= 1'b1;
                end
            end

            NOTIFY_USER: begin
                // Notify the user and wait for acknowledgment
                if (ack == 1'b1) begin
                    state <= WAIT_PATTERN;
                    done <= 1'b0;
                end
            end

            default: begin
                state <= WAIT_PATTERN;
            end
        endcase
    end
end

endmodule
