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

    // State declaration
    typedef enum reg [2:0] {
        S_IDLE,     	// Start state, look for 1101
        S_SHIFT,    	// Shift 4 bits to get delay
        S_COUNT,    	// Wait for counters to finish
        S_DONE       	// Notify the user and wait for ack
    } state_t;
    
    state_t state, next_state;
    reg [3:0] pattern_shift;
    reg [2:0] shift_counter;

    // State transitions
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= S_IDLE;
        else 
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        next_state = state; // Default to stay in the same state
        
        case (state)
            S_IDLE: begin
                if ({pattern_shift[2:0], data} == 4'b1101) 
                    next_state = S_SHIFT;
            end
            
            S_SHIFT: begin
                if (shift_counter == 3)
                    next_state = S_COUNT;
            end
            
            S_COUNT: begin
                if (done_counting) 
                    next_state = S_DONE;
            end
            
            S_DONE: begin
                if (ack) 
                    next_state = S_IDLE;
            end
        endcase
    end

    // Output logic and pattern shift register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
            pattern_shift <= 4'b0000;
            shift_counter <= 0;
        end
        else begin
            case (state)
                S_IDLE: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done => 0;
                    pattern_shift <= {pattern_shift[2:0], data};
                    shift_counter <= 0; // Reset shift counter
                end
                
                S_SHIFT: begin
                    shift_ena <= 1;
                    shift_counter <= shift_counter + 1;
                end

                S_COUNT: begin
                    shift_ena <= 0;
                    counting <= 1;
                end
                
                S_DONE: begin
                    counting <= 0;
                    done <= 1;
                end
            endcase
        end
    end

endmodule
