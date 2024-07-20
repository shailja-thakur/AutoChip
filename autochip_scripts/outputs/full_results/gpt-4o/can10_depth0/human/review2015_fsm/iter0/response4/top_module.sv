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
    typedef enum reg [3:0] {
        IDLE,
        DETECT_1,
        DETECT_11,
        DETECT_110,
        DETECT_1101,
        SHIFT,
        COUNTING,
        DONE_WAIT_ACK
    } state_t;
    
    state_t state, next_state;
    reg [2:0] shift_counter;
    
    // Synchronous state transition
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= IDLE;
        else 
            state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        shift_ena = 0;
        counting = 0;
        done = 0;
        next_state = state;
        
        case (state)
            IDLE: begin
                if (data)
                    next_state = DETECT_1;
            end
            DETECT_1: begin
                if (data)
                    next_state = DETECT_11;
                else
                    next_state = IDLE;
            end
            DETECT_11: begin
                if (data)
                    next_state = DETECT_110;
                else
                    next_state = IDLE;
            end
            DETECT_110: begin
                if (data)
                    next_state = DETECT_1101;
                else
                    next_state = IDLE;
            end
            DETECT_1101: begin
                next_state = SHIFT;
            end
            SHIFT: begin
                shift_ena = 1;
                if (shift_counter == 4)
                    next_state = COUNTING;
            end
            COUNTING: begin
                counting = 1;
                if (done_counting)
                    next_state = DONE_WAIT_ACK;
            end
            DONE_WAIT_ACK: begin
                done = 1;
                if (ack)
                    next_state = IDLE;
            end
        endcase
    end
    
    // Shift counter logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            shift_counter <= 0;
        else if (state == SHIFT)
            shift_counter <= shift_counter + 1;
        else
            shift_counter <= 0;
    end

endmodule
