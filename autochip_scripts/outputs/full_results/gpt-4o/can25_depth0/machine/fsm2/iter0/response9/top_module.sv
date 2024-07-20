module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // Define the states
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // Combinational always block for next-state logic
    always @(*) begin
        case (state)
            A: next_state = j ? B : A;
            B: next_state = k ? A : B;
            default: next_state = A; // Default to state A
        endcase
    end

    // Sequential always block for state updating
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A; // Reset state to A
        else
            state <= next_state; // Update state
    end

    // Output logic
    always @(state) begin
        out = (state == B);
    end

endmodule
