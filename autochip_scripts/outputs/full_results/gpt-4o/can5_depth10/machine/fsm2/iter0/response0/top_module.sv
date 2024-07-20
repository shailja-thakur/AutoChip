module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    // State encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;

    state_t state, next_state;

    // Combinational logic for next state
    always_comb begin
        case (state)
            A: next_state = j ? B : A;
            B: next_state = k ? A : B;
            default: next_state = A;
        endcase
    end

    // Sequential logic for state update
    always_ff @(posedge clk or posedge areset) begin
        if (areset) 
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    assign out = (state == B);

endmodule
