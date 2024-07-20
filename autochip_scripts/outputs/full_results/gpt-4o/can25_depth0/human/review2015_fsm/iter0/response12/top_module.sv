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

    typedef enum reg [2:0] {IDLE, PATTERN_DETECT, SHIFT, COUNT, DONE_WAIT} state_t;
    state_t current_state, next_state;

    reg [3:0] shift_counter;
    reg [3:0] pattern_shift_reg;
    
    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // State machine
    always @(*) begin
        // Default values
        shift_ena = 0;
        counting = 0;
        done = 0;
        next_state = current_state;

        case (current_state)
            IDLE: begin
                pattern_shift_reg[3:1] = pattern_shift_reg[2:0];
                pattern_shift_reg[0] = data;
                if (pattern_shift_reg == 4'b1101)
                    next_state = PATTERN_DETECT;
                else
                    next_state = IDLE;
            end
            PATTERN_DETECT: begin
                next_state = SHIFT;
            end
            SHIFT: begin
                shift_ena = 1;
                if (shift_counter == 4) 
                    next_state = COUNT;
                else
                    shift_counter = shift_counter + 1;
            end
            COUNT: begin
                counting = 1;
                if (done_counting)
                    next_state = DONE_WAIT;
                else
                    next_state = COUNT;
            end
            DONE_WAIT: begin
                done = 1;
                if (ack)
                    next_state = IDLE;
                else
                    next_state = DONE_WAIT;
            end
        endcase
    end

    // Counter for SHIFT state
    always @(posedge clk or posedge reset) begin
        if (reset)
            shift_counter <= 0;
        else if (current_state == SHIFT)
            shift_counter <= shift_counter + 1;
        else
            shift_counter <= 0;
    end

    // Register to hold the incoming bits and detect the pattern
    always @(posedge clk or posedge reset) begin
        if (reset)
            pattern_shift_reg <= 0;
        else if (current_state == IDLE)
            pattern_shift_reg <= {pattern_shift_reg[2:0], data};
    end

endmodule
