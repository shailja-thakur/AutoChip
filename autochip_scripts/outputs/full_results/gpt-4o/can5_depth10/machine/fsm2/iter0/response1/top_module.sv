module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // State encoding
    typedef enum logic [0:0] {
        A = 1'b0,
        B = 1'b1
    } state_t;

    state_t state, next_state;

    // Combinational logic for next state
    always_comb begin
        case (state)
            A: next_state = (j) ? B : A;
            B: next_state = (k) ? A : B;
            default: next_state = A;
        endcase
    end

    // Synchronous state update
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            out <= 1'b0;
        else
            out <= (state == B) ? 1'b1 : 1'b0;
    end

endmodule
