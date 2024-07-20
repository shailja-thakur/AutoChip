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

    // State Declaration
    typedef enum reg [2:0] {
        IDLE,
        S1, // 1 detected
        S11, // 11 detected
        S110, // 110 detected
        S1101, // 1101 detected
        SHIFT, // Shift enable for 4 cycles
        COUNT, // Waiting for counting to finish
        DONE // Timer done, waiting for ack
    } state_t;
    
    state_t state, next_state;
    
    reg [1:0] shift_counter;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    always @(*) begin
        shift_ena = 0;
        counting = 0;
        done = 0;
        next_state = state;
        
        case (state)
            IDLE: begin
                if (data)
                    next_state = S1;
            end
            
            S1: begin
                if (data)
                    next_state = S11;
                else
                    next_state = IDLE;
            end
            
            S11: begin
                if (~data)
                    next_state = S110;
                else
                    next_state = IDLE;
            end
            
            S110: begin
                if (data)
                    next_state = S1101;
                else
                    next_state = IDLE;
            end
            
            S1101: begin
                shift_ena = 1;
                next_state = SHIFT;
                shift_counter = 0;
            end
            
            SHIFT: begin
                shift_ena = 1;
                shift_counter = shift_counter + 1;
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
