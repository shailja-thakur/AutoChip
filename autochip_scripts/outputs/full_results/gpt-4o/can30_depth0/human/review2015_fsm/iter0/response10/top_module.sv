module top_module(
	input clk,
	input reset,
	input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // State encoding
    typedef enum reg [2:0] {
        IDLE,
        DETECT1,
        DETECT11,
        DETECT110,
        DETECT1101,
        SHIFT,
        COUNT,
        DONE
    } state_t;

    state_t state, next_state;
    reg [2:0] shift_counter;

    // State transitions
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_counter <= 0;
        end else begin
            state <= next_state;
            if (state == SHIFT)
                shift_counter <= shift_counter + 1;
            else
                shift_counter <= 0;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state; // Default to hold state
        shift_ena = 0;
        counting = 0;
        done = 0;
        
        case (state)
            IDLE: begin
                if (data == 1)
                    next_state = DETECT1;
            end
            DETECT1: begin
                if (data == 1)
                    next_state = DETECT11;
                else
                    next_state = IDLE;
            end
            DETECT11: begin
                if (data == 0)
                    next_state = DETECT110;
                else
                    next_state = IDLE;   
            end
            DETECT110: begin
                if (data == 1)
                    next_state = DETECT1101;
                else
                    next_state = IDLE;
            end
            DETECT1101: begin
                next_state = SHIFT;
            end
            SHIFT: begin
                shift_ena = 1;
                if (shift_counter == 3)
                    next_state = COUNT;
            end
            COUNT: begin
                counting = 1;
                if (done_counting)
                    next_state = DONE;
            end
            DONE: begin
                done = 1;
                if (ack)
                    next_state = IDLE;
            end
        endcase
    end
endmodule
