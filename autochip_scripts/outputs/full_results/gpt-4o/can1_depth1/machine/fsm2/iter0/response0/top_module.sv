module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    // State encoding
    typedef enum logic {
        A = 1'b0,
        B = 1'b1
    } state_t;

    // Current state and next state variables
    state_t state, next_state;

    // Combinational block to determine next state
    always_comb begin
        case (state)
            A: next_state = j ? B : A;
            B: next_state = k ? A : B;
            default: next_state = A;
        endcase
    end

    // Sequential block to update current state
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    assign out = (state == B);

endmodule
