module top_module(
	input clk,
	input reset,
	input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    //Define states
    typedef enum reg [2:0] {
        IDLE,        // Wait for the pattern 1101
        SHIFT,       // Shift in the duration
        COUNTING,    // Wait for the counters to finish counting
        DONE,        // Notify the user timer has timed out, and wait for acknowledgment
        WAIT_ACK     // Wait for user to acknowledge
    } state_t;
    
    state_t state, next_state;
    reg [3:0] pattern_shift;
    reg [3:0] bit_counter;
    
    // Sequential state transition on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            pattern_shift <= 4'd0;
            bit_counter <= 4'd0;
        end else begin
            state <= next_state;
            if (shift_ena)
                bit_counter <= bit_counter + 1;
            else
                bit_counter <= 4'd0;
        end
    end
    
    // Combinational logic to determine next state
    always @(*) begin
        next_state = state;
        shift_ena = 0;
        counting = 0;
        done = 0;
        
        case (state)
            IDLE: begin
                pattern_shift = {pattern_shift[2:0], data};
                if (pattern_shift == 4'b1101)
                    next_state = SHIFT;
            end
            
            SHIFT: begin
                shift_ena = 1;
                if (bit_counter == 4'd4)   // Shift for 4 clock cycles
                    next_state = COUNTING;
            end
            
            COUNTING: begin
                counting = 1;
                if (done_counting)
                    next_state = DONE;
            end
            
            DONE: begin
                done = 1;
                if (ack)
                    next_state = IDLE;
            end
            
            default: next_state = IDLE;
        endcase
    end

endmodule
