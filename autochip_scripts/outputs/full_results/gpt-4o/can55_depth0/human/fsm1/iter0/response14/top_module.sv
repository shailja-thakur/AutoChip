module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    // Define the states
    typedef enum logic {
        A = 1'b0,
        B = 1'b1
    } state_t;

    state_t state, next_state;

    // Asynchronous reset logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= B;
        else
            state <= next_state;
    end

    // Next state logic (combinational)
    always_comb begin
        case (state)
            A: if (in) next_state = A;
               else next_state = B;
            B: if (in) next_state = B;
               else next_state = A;
            default: next_state = B; // Default to safe state B
        endcase
    end

    // Output logic is state-dependent
    assign out = (state == B);

endmodule
