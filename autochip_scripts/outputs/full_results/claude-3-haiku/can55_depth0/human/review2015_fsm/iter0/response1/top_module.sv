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

localparam WAIT_START = 0;
localparam SHIFT_DURATION = 1;
localparam COUNT = 2;
localparam NOTIFY = 3;
localparam WAIT_ACK = 4;

reg [2:0] state;
reg [3:0] shift_count;
reg [3:0] pattern;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= WAIT_START;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
        shift_count <= 0;
        pattern <= 0;
    end else begin
        case (state)
            WAIT_START: begin
                // Shift in the input bits and check for the start pattern 1101
                pattern <= {pattern[2:0], data};
                if (pattern == 4'b1101) begin
                    state <= SHIFT_DURATION;
                    shift_count <= 0;
                    shift_ena <= 1;
                end else begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                end
            end
            SHIFT_DURATION: begin
                // Shift in 4 bits to determine the delay duration
                shift_count <= shift_count + 1;
                if (shift_count == 4) begin
                    state <= COUNT;
                    shift_ena <= 0;
                    counting <= 1;
                end
            end
            COUNT: begin
                // Wait for the counters to finish
                if (done_counting) begin
                    state <= NOTIFY;
                    counting <= 0;
                    done <= 1;
                end
            end
            NOTIFY: begin
                // Wait for the user to acknowledge the timer
                if (ack) begin
                    state <= WAIT_START;
                    done <= 0;
                end
            end
            default: state <= WAIT_START;
        endcase
    end
end

endmodule
