module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State encoding
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // Asynchronous reset logic and state transition
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= B; // Asynchronous reset to state B
        else
            state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            B: begin
                if (in)
                    next_state = B;
                else
                    next_state = A;
                out = 1;
            end
            A: begin
                if (in)
                    next_state = A;
                else
                    next_state = B;
                out = 0;
            end
            default: begin
                next_state = B; // Default state
                out = 1;
            end
        endcase
    end

endmodule
