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
        IDLE,
        PATTERN_DETECT,
        SHIFT,
        WAIT_COUNT,
        DONE,
        WAIT_ACK
    } state_t;
    
    state_t state, next_state;
    reg [3:0] pattern, pattern_shift;

    // State transition block
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            pattern <= 4'b0000;
        end
        else begin
            state <= next_state;
            if (state == PATTERN_DETECT || state == IDLE) begin
                pattern <= {pattern[2:0], data};
            end
        end
    end
    
    // Next state logic and output logic
    always @(*) begin
        // Default values
        next_state = state;
        shift_ena = 0;
        counting = 0;
        done = 0;
        
        case (state)
            IDLE: begin
                if (pattern == 4'b1101) begin
                    next_state = SHIFT;
                end
            end
            
            SHIFT: begin
                shift_ena = 1;
                if (pattern_shift == 4'b1111)
                    next_state = WAIT_COUNT;
                else
                    next_state = SHIFT;
            end
            
            WAIT_COUNT: begin
                counting = 1;
                if (done_counting) begin
                    next_state = DONE;
                end
            end
            
            DONE: begin
                done = 1;
                if (ack) begin
                    next_state = IDLE;
                    pattern_shift = 4'b0000;
                end else
                    next_state = DONE;
            end
            
            default: next_state = IDLE;
        endcase
    end
    
    // Pattern shift register for SHIFT state
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pattern_shift <= 4'b0000;
        end
        else if (state == SHIFT && (pattern_shift != 4'b1111)) begin
            pattern_shift <= pattern_shift + 1;
        end
        else if (state == WAIT_COUNT) begin
            pattern_shift <= 4'b0000;
        end
    end
endmodule
