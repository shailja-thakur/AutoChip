module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    // Define state encoding
    typedef enum logic [1:0] {
        A = 1'b0,
        B = 1'b1
    } state_t;

    state_t state, next_state;

    // Combinational block to determine the next state
    always_comb begin
        case (state)
            A: next_state = j ? B : A;
            B: next_state = k ? A : B;
            default: next_state = A;
        endcase
    end

    // Clocked block to update the current state
    always_ff @(posedge clk or posedge areset) begin
        if (areset) 
            state <= A;
        else 
            state <= next_state;
    end

    // Output logic
    assign out = (state == B);

endmodule
