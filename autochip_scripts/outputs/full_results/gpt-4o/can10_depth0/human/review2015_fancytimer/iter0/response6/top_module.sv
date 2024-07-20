module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // State machine states
    typedef enum reg [2:0] {
        IDLE,
        PATTERN_DETECT,
        READ_DELAY,
        COUNT,
        DONE
    } state_t;

    state_t state, next_state;

    // Pattern detection and delay storage registers
    reg [3:0] pattern_shift_reg;
    reg [3:0] delay;
    reg [12:0] timer; // Up to 16000 cycles (16,000 = 2^4 * 1000)

    // Always block for state transitions
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic and output logic
    always @(*) begin
        next_state = state;
        counting = 0;
        done = 0;
        
        case (state)
            IDLE: begin
                if (reset) next_state = IDLE;
                else next_state = PATTERN_DETECT;
                pattern_shift_reg = 4'b0000;
            end

            PATTERN_DETECT: begin
                pattern_shift_reg = {pattern_shift_reg[2:0], data};
                if (pattern_shift_reg == 4'b1101) next_state = READ_DELAY;
            end

            READ_DELAY: begin
                pattern_shift_reg = {pattern_shift_reg[2:0], data};
                if (&pattern_shift_reg) begin
                    delay = pattern_shift_reg;
                    timer = (pattern_shift_reg + 1) * 1000;
                    next_state = COUNT;
                end
            end

            COUNT: begin
                counting = 1;
                if (timer == 0) begin
                    next_state = DONE;
                end else begin
                    count = timer / 1000;
                    timer = timer - 1;
                end
            end
            
            DONE: begin
                done = 1;
                if (ack) next_state = IDLE;
            end

            default: next_state = IDLE;
        endcase
    end
endmodule
