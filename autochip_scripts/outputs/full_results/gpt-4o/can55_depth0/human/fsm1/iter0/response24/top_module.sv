module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State Declarations
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // Asynchronous Reset Logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= B; // Reset to state B
        else
            state <= next_state;
    end

    // Next State Logic
    always @(*) begin
        case (state)
            A: if (in)
                   next_state = A;
               else
                   next_state = B;
            B: if (in)
                   next_state = B;
               else
                   next_state = A;
            default: next_state = B; // Safe default state
        endcase
    end

    // Output Logic
    always @(*) begin
        case (state)
            A: out = 0;
            B: out = 1;
            default: out = 1; // Safe default output
        endcase
    end

endmodule
