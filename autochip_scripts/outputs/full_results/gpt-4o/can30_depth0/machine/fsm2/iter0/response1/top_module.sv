module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    // State encoding
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // Combinational block to determine next state
    always @(*) begin
        case (state)
            A: next_state = (j) ? B : A;
            B: next_state = (k) ? A : B;
            default: next_state = A; // default case to ensure stability
        endcase
    end

    // Clocked block to update state based on reset and next state
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    assign out = (state == B);

endmodule
