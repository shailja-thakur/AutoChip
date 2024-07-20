module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // Define state encoding
    typedef enum logic [2:0] {
        S_IDLE         = 3'd0,
        S_DETECT_1     = 3'd1,
        S_DETECT_11    = 3'd2,
        S_DETECT_110   = 3'd3,
        S_DETECT_1101  = 3'd4,
        S_SHIFT        = 3'd5,
        S_COUNT        = 3'd6,
        S_DONE         = 3'd7
    } state_t;
    
    state_t state, next_state;
    reg [2:0] shift_counter;
    
    // State machine transitions
    always_ff @(posedge clk or posedge reset) begin
        if (reset) 
            state <= S_IDLE;
        else 
            state <= next_state;
    end
    
    // Next state logic
    always_comb begin
        next_state = state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
        
        case (state)
            S_IDLE: begin
                if (data == 1'b1)
                    next_state = S_DETECT_1;
            end
            
            S_DETECT_1: begin
                if (data == 1'b1)
                    next_state = S_DETECT_11;
                else
                    next_state = S_IDLE;
            end
            
            S_DETECT_11: begin
                if (data == 1'b0)
                    next_state = S_DETECT_110;
                else
                    next_state = S_IDLE;
            end
            
            S_DETECT_110: begin
                if (data == 1'b1)
                    next_state = S_DETECT_1101;
                else
                    next_state = S_IDLE;
            end

            S_DETECT_1101: begin
                next_state = S_SHIFT;
            end
            
            S_SHIFT: begin
                shift_ena = 1'b1;
                if (shift_counter == 3'd3)
                    next_state = S_COUNT;
            end
            
            S_COUNT: begin
                counting = 1'b1;
                if (done_counting)
                    next_state = S_DONE;
            end
            
            S_DONE: begin
                done = 1'b1;
                if (ack)
                    next_state = S_IDLE;
            end
        endcase
    end
    
    // Shift counter logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) 
            shift_counter <= 3'd0;
        else if (state == S_SHIFT) 
            shift_counter <= shift_counter + 1'b1;
        else if (state != S_SHIFT)
            shift_counter <= 3'd0;
    end
    
endmodule
