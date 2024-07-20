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

reg [2:0] state, next_state;
reg [3:0] pattern_shift;

// State definitions
localparam WAIT_FOR_PATTERN = 3'b000;
localparam SHIFT_DURATION   = 3'b001;
localparam WAIT_FOR_DONE    = 3'b010;
localparam NOTIFY_USER      = 3'b011;
localparam WAIT_FOR_ACK     = 3'b100;

// State update logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= WAIT_FOR_PATTERN;
    end
    else begin
        state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case (state)
        WAIT_FOR_PATTERN: begin
            if (pattern_shift == 4'b1101) begin
                next_state = SHIFT_DURATION;
            end
            else begin
                next_state = WAIT_FOR_PATTERN;
            end
        end
        SHIFT_DURATION: begin
            next_state = WAIT_FOR_DONE;
        end
        WAIT_FOR_DONE: begin
            if (done_counting) begin
                next_state = NOTIFY_USER;
            end
            else begin
                next_state = WAIT_FOR_DONE;
            end
        end
        NOTIFY_USER: begin
            next_state = WAIT_FOR_ACK;
        end
        WAIT_FOR_ACK: begin
            if (ack) begin
                next_state = WAIT_FOR_PATTERN;
            end
            else begin
                next_state = WAIT_FOR_ACK;
            end
        end
        default: begin
            next_state = WAIT_FOR_PATTERN;
        end
    endcase
end

// Output logic
always @(*) begin
    shift_ena = 0;
    counting = 0;
    done = 0;
    case (state)
        WAIT_FOR_PATTERN: begin
            // Shift in the next bit
            pattern_shift = {pattern_shift[2:0], data};
        end
        SHIFT_DURATION: begin
            shift_ena = 1;
        end
        WAIT_FOR_DONE: begin
            counting = 1;
        end
        NOTIFY_USER: begin
            done = 1;
        end
        default: begin
            // No outputs asserted
        end
    endcase
end

endmodule
