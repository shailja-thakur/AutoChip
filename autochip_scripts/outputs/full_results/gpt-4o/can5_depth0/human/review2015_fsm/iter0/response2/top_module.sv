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
    // Define state machine states
    typedef enum reg [2:0] {
        IDLE,
        PATTERN_DETECT,
        SHIFT,
        COUNTING,
        DONE
    } state_t;

    state_t state, next_state;

    // Pattern matching variables
    reg [3:0] pattern;

    // Synchronous state and output registers
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;  // default stay in same state
        shift_ena = 0;
        counting = 0;
        done = 0;

        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    pattern = {pattern[2:0], data};
                end else if (&pattern == 4'b1101) begin
                    next_state = PATTERN_DETECT;
                end
            end

            PATTERN_DETECT: begin
                pattern = {pattern[2:0], data};
                if (&pattern == 4'b1101) begin
                    next_state = SHIFT;
                end
            end

            SHIFT: begin
                shift_ena = 1;
                if (/* 4 clock cycles have passed */) begin
                    next_state = COUNTING;
                end
            end

            COUNTING: begin
                counting = 1;
                if (done_counting) begin
                    next_state = DONE;
                end
            end

            DONE: begin
                done = 1;
                if (ack) begin
                    next_state = IDLE;
                end
            end

            default: next_state = IDLE;
        endcase
    end

endmodule
