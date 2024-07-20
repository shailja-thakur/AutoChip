module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    // State declaration
    typedef enum logic {A, B} state_t;
    state_t state, next_state;

    // Combinational logic to determine next state
    always_comb begin
        case (state)
            A: next_state = (j) ? B : A;
            B: next_state = (k) ? A : B;
            default: next_state = A; // Default state for safety
        endcase
    end

    // Synchronous logic for state transition
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    assign out = (state == B);

endmodule
