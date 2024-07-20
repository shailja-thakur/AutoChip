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

localparam WAIT_START = 4'b0000;
localparam SHIFT_ENABLE = 4'b0001;
localparam WAIT_COUNT = 4'b0010;
localparam NOTIFY_USER = 4'b0011;
localparam WAIT_ACK = 4'b0100;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        pattern <= 4'b0000;
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end else begin
        case (state)
            WAIT_START: begin
                // Shift in the input data
                pattern <= {pattern[2:0], data};
                // Check for the start pattern 1101
                if (pattern == 4'b1101) begin
                    state <= SHIFT_ENABLE;
                    shift_ena <= 1'b1;
                end else begin
                    shift_ena <= 1'b0;
                end
            end
            SHIFT_ENABLE: begin
                // Shift in 4 more bits to get the delay duration
                pattern <= {pattern[2:0], data};
                // After 4 clock cycles, disable the shift_ena
                if (pattern == 4'b1111) begin
                    state <= WAIT_COUNT;
                    shift_ena <= 1'b0;
                    counting <= 1'b1;
                end
            end
            WAIT_COUNT: begin
                // Wait for the counters to finish
                if (done_counting) begin
                    state <= NOTIFY_USER;
                    counting <= 1'b0;
                    done <= 1'b1;
                end
            end
            NOTIFY_USER: begin
                // Wait for the user to acknowledge the timer
                if (ack) begin
                    state <= WAIT_START;
                    done <= 1'b0;
                end
            end
            default: begin
                state <= WAIT_START;
            end
        endcase
    end
end

endmodule
