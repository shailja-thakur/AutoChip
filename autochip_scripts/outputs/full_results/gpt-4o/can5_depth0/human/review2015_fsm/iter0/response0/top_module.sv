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
    typedef enum reg [2:0] {
        IDLE,
        PATTERN_DETECT,
        SHIFT_ENABLE,
        WAIT_COUNT,
        DONE_WAIT_ACK
    } state_t;
 
    state_t state, next_state;
    
    // Pattern detection
    reg [3:0] shift_reg;
    
    // State machine sequential logic (state transition)
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // State machine combinational logic (next state logic)
    always @(*) begin
        // Default output values
        shift_ena = 0;
        counting = 0;
        done = 0;
        
        case (state)
            IDLE: begin
                if (shift_reg == 4'b1101) 
                    next_state = SHIFT_ENABLE;
                else 
                    next_state = IDLE;
            end

            SHIFT_ENABLE: begin
                shift_ena = 1;
                next_state = SHIFT_ENABLE;
                if (state == SHIFT_ENABLE && shift_ena == 1) begin
                    next_state = WAIT_COUNT;
                end
            end
            
            WAIT_COUNT: begin
                counting = 1;
                if (done_counting) 
                    next_state = DONE_WAIT_ACK;
                else 
                    next_state = WAIT_COUNT;
            end

            DONE_WAIT_ACK: begin
                done = 1;
                if (ack) 
                    next_state = IDLE;
                else 
                    next_state = DONE_WAIT_ACK;
            end

            default: next_state = IDLE;
        endcase
    end
    
    // Shift register for pattern detection
    always @(posedge clk or posedge reset) begin
        if (reset) 
            shift_reg <= 4'b0;
        else if (state == IDLE || state == PATTERN_DETECT) 
            shift_reg <= {shift_reg[2:0], data};
    end
endmodule
