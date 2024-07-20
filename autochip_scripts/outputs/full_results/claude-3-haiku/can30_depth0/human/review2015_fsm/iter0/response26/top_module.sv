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

// Define the states for the finite state machine
parameter [2:0] WAIT_PATTERN = 3'b000,
                SHIFT_DURATION = 3'b001,
                COUNT = 3'b010,
                NOTIFY = 3'b011,
                ACKNOWLEDGE = 3'b100;

reg [2:0] state, next_state;
reg [3:0] pattern;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_PATTERN;
        pattern <= 4'b0;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        pattern <= {pattern[2:0], data};
    end
end

always @(*) begin
    next_state = state;
    case (state)
        WAIT_PATTERN: begin
            if (pattern == 4'b1101) begin
                next_state = SHIFT_DURATION;
                shift_ena = 1;
            end
            else begin
                shift_ena = 0;
            end
            counting = 0;
            done = 0;
        end
        SHIFT_DURATION: begin
            if (shift_ena) begin
                shift_ena = 1;
            end
            else begin
                shift_ena = 0;
                next_state = COUNT;
                counting = 1;
            end
            done = 0;
        end
        COUNT: begin
            if (done_counting) begin
                next_state = NOTIFY;
                counting = 0;
            end
            else begin
                counting = 1;
            end
            shift_ena = 0;
            done = 0;
        end
        NOTIFY: begin
            done = 1;
            shift_ena = 0;
            counting = 0;
            if (ack) begin
                next_state = WAIT_PATTERN;
            end
        end
        ACKNOWLEDGE: begin
            next_state = WAIT_PATTERN;
            shift_ena = 0;
            counting = 0;
            done = 0;
        end
        default: begin
            next_state = WAIT_PATTERN;
            shift_ena = 0;
            counting = 0;
            done = 0;
        end
    endcase
end

endmodule
