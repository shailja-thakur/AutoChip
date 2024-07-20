module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // Define the states
    typedef enum logic [1:0] {A, B} state_t;
    state_t current_state, next_state;

    // Combinational logic for next state
    always_comb begin
        case (current_state)
            A: next_state = (j) ? B : A;
            B: next_state = (k) ? A : B;
            default: next_state = A; // Default case to handle unexpected conditions
        endcase
    end

    // Clocked logic for state transition
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // Output logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            out <= 0;
        else
            out <= (current_state == B);
    end

endmodule
