module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State encoding
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // State transition on clock or asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= B; // Asynchronous reset to state B
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case(state)
            B: 
                if (in) 
                    next_state = B;
                else 
                    next_state = A;
            A: 
                if (in) 
                    next_state = A;
                else 
                    next_state = B;
            default: 
                next_state = B; // Default state (should not happen)
        endcase
    end

    // Output logic
    always @(*) begin
        case(state)
            B: 
                out = 1;
            A: 
                out = 0;
            default: 
                out = 1; // Default output (should not happen)
        endcase
    end

endmodule
