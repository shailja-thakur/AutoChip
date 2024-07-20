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
    // Declare states
    typedef enum reg [3:0] {
        IDLE,            // Look for 1101
        DETECT_1,        // Detected 1, look for 1
        DETECT_11,       // Detected 11, look for 0
        DETECT_110,      // Detected 110, look for 1
        SHIFT,           // Shift 4-bit data
        WAIT_COUNT,      // Wait for counters to finish counting
        NOTIFY           // Notify user
    } state_t;
    state_t state, next_state;
    
    // State transition logic (sequential)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end
        else begin
            state <= next_state;
        end
    end
    
    // Next state logic (combinational)
    always @(*) begin
        // Default outputs
        shift_ena = 0;
        counting = 0;
        done = 0;
        next_state = state;
        
        case (state)
            IDLE: begin
                if (data) next_state = DETECT_1;
            end
            
            DETECT_1: begin
                if (data) next_state = DETECT_11;
                else next_state = IDLE;
            end
            
            DETECT_11: begin
                if (!data) next_state = DETECT_110;
                else next_state = DETECT_1;
            end
            
            DETECT_110: begin
                if (data) next_state = SHIFT;
                else next_state = IDLE;
            end
            
            SHIFT: begin
                shift_ena = 1;
                if (|4'b1111) begin  // After 4 cycles
                    next_state = WAIT_COUNT;
                end
            end
            
            WAIT_COUNT: begin
                counting = 1;
                if (done_counting) next_state = NOTIFY;
            end
            
            NOTIFY: begin
                done = 1;
                if (ack) next_state = IDLE;
            end
        endcase
    end

endmodule
