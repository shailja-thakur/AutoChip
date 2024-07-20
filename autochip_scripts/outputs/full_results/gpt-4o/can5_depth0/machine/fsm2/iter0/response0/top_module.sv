module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    // Define the states
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // Combinational always block to determine next state
    always @(*) begin
        case(state)
            A: next_state = j ? B : A;
            B: next_state = k ? A : B;
            default: next_state = A; // Default case to avoid latches
        endcase
    end

    // Clocked always block to update state based on areset and next state
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    assign out = (state == B);

endmodule
