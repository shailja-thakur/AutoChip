module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // Enumeration for states
    typedef enum reg {OFF, ON} state_t;
    state_t state, next_state;
    
    // State transition logic (next state)
    always @(posedge clk) begin
        if (reset) 
            state <= OFF;
        else 
            state <= next_state;
    end

    // Next state and output logic
    always @(state or j or k) begin
        case (state)
            OFF: begin
                out = 0;
                if (j)
                    next_state = ON;
                else
                    next_state = OFF;
            end

            ON: begin
                out = 1;
                if (k)
                    next_state = OFF;
                else
                    next_state = ON;
            end

            default: begin
                out = 0;
                next_state = OFF;
            end
        endcase
    end
endmodule
