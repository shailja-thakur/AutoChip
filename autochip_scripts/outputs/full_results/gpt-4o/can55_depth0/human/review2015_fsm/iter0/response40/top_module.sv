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
    typedef enum logic[2:0] {
        IDLE            = 3'b000,  // Waiting for pattern 1101
        SHIFT           = 3'b001,  // Enable shifting for 4 cycles
        WAIT_COUNT      = 3'b010,  // Waiting for the counter to finish
        TIMER_DONE      = 3'b011,  // Timer done, waiting for ack
        WAIT_ACK        = 3'b100   // Waiting for acknowledgment
    } state_t;
    
    state_t state, next_state;
    reg [3:0] shift_counter;
    reg [3:0] pattern_shift_reg;
    
    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_counter <= 0;
            pattern_shift_reg <= 0;
        end else begin
            state <= next_state;
            if (state == SHIFT)
                shift_counter <= shift_counter + 1;
            else if (state == IDLE)
                shift_counter <= 0;
                
            if (state == IDLE)
                pattern_shift_reg <= {pattern_shift_reg[2:0], data};
        end
    end
    
    // Next state logic
    always @(*) begin
        // Default assignments
        shift_ena = 0;
        counting = 0;
        done = 0;
        
        case (state)
            IDLE: begin
                if (pattern_shift_reg == 4'b1101 && data) // Detect pattern 1101
                    next_state = SHIFT;
                else
                    next_state = IDLE;
            end
            
            SHIFT: begin
                shift_ena = 1;
                if (shift_counter == 4) // Shift for 4 cycles
                    next_state = WAIT_COUNT;
                else
                    next_state = SHIFT;
            end
            
            WAIT_COUNT: begin
                counting = 1;
                if (done_counting)
                    next_state = TIMER_DONE;
                else
                    next_state = WAIT_COUNT;
            end
            
            TIMER_DONE: begin
                done = 1;
                if (ack)
                    next_state = IDLE;
                else
                    next_state = WAIT_ACK;
            end
            
            WAIT_ACK: begin
                done = 1;
                if (ack)
                    next_state = IDLE;
                else
                    next_state = WAIT_ACK;
            end
            
            default: next_state = IDLE;
        endcase
    end
endmodule
