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

parameter WAIT_START = 0, SHIFT_DURATION = 1, WAIT_COMPLETE = 2, NOTIFY_USER = 3;

reg [1:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
        shift_count <= 0;
    end
    else begin
        state <= next_state;

        case (state)
            WAIT_START: begin
                // Look for start pattern 1101
                if (data == 1 && data == 1 && data == 0 && data == 1) begin
                    next_state <= SHIFT_DURATION;
                    shift_count <= 0;
                    shift_ena <= 1;
                end
                else begin
                    next_state <= WAIT_START;
                    shift_ena <= 0;
                end
            end

            SHIFT_DURATION: begin
                // Shift in 4 bits to determine the timer duration
                if (shift_count < 4) begin
                    shift_count <= shift_count + 1;
                end
                else begin
                    shift_ena <= 0;
                    next_state <= WAIT_COMPLETE;
                    counting <= 1;
                end
            end

            WAIT_COMPLETE: begin
                // Wait for the counters to finish
                if (done_counting) begin
                    next_state <= NOTIFY_USER;
                    counting <= 0;
                    done <= 1;
                end
                else begin
                    next_state <= WAIT_COMPLETE;
                end
            end

            NOTIFY_USER: begin
                // Wait for user acknowledgement
                if (ack) begin
                    next_state <= WAIT_START;
                    done <= 0;
                end
                else begin
                    next_state <= NOTIFY_USER;
                end
            end

            default: begin
                next_state <= WAIT_START;
            end
        endcase
    end
end

endmodule
