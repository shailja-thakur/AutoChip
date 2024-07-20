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

// Define the states for the finite-state machine
localparam [2:0] 
    WAIT_FOR_PATTERN = 3'b000,
    SHIFT_DURATION   = 3'b001,
    COUNT_DURATION   = 3'b010,
    NOTIFY_USER      = 3'b011,
    WAIT_FOR_ACK     = 3'b100;

reg [2:0] state, next_state;
reg [3:0] pattern_shift;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FOR_PATTERN;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    // Default values
    next_state = state;
    shift_ena = 1'b0;
    counting = 1'b0;
    done = 1'b0;

    case (state)
        WAIT_FOR_PATTERN: begin
            // Shift in the next bit from the data input
            pattern_shift <= {pattern_shift[2:0], data};
            // Check if the pattern 1101 has been detected
            if (pattern_shift == 4'b1101) begin
                next_state = SHIFT_DURATION;
                shift_ena = 1'b1;
            end
        end
        SHIFT_DURATION: begin
            // Shift in 4 more bits to determine the duration
            shift_ena = 1'b1;
            if (shift_ena == 1'b1 && data == 1'b0) begin
                // After 4 clock cycles, move to the count state
                next_state = COUNT_DURATION;
            end
        end
        COUNT_DURATION: begin
            counting = 1'b1;
            if (done_counting) begin
                next_state = NOTIFY_USER;
            end
        end
        NOTIFY_USER: begin
            done = 1'b1;
            next_state = WAIT_FOR_ACK;
        end
        WAIT_FOR_ACK: begin
            if (ack) begin
                next_state = WAIT_FOR_PATTERN;
            end
        end
    endcase
end

endmodule
