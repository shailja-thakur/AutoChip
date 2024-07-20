module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // State declaration
    typedef enum logic [2:0] {
        IDLE,           // Idle state - looking for pattern 1101
        PATTERN_DETECTED, // Pattern detected - enable shifting
        WAIT_COUNT,     // Wait for the counters to finish counting
        DONE_STATE      // Counting done - wait for acknowledgment from user
    } state_t;

    state_t state, next_state;
    reg [3:0] pattern_shift_reg;

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        // Default values
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
        next_state = state;

        case(state)
            IDLE: begin
                if (pattern_shift_reg == 4'b1101)
                    next_state = PATTERN_DETECTED;
                else
                    next_state = IDLE;
            end
            PATTERN_DETECTED: begin
                shift_ena = 1'b1;
                next_state = (shift_ena == 1'b1) ? WAIT_COUNT : PATTERN_DETECTED;
            end
            WAIT_COUNT: begin
                counting = 1'b1;
                if (done_counting)
                    next_state = DONE_STATE;
                else
                    next_state = WAIT_COUNT;
            end
            DONE_STATE: begin
                done = 1'b1;
                if (ack)
                    next_state = IDLE;
                else
                    next_state = DONE_STATE;
            end
            default: next_state = IDLE;
        endcase
    end

    // Pattern shift register and pattern detection
    always @(posedge clk or posedge reset) begin
        if (reset)
            pattern_shift_reg <= 4'b0000;
        else if (state == IDLE)
            pattern_shift_reg <= {pattern_shift_reg[2:0], data};
    end

endmodule
