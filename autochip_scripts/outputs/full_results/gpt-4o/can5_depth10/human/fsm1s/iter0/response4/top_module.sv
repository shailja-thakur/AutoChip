module top_module (
    input clk,
    input in,
    input reset,
    output out
);
    // State Encoding
    typedef enum logic [0:0] {
        A = 1'b0,
        B = 1'b1
    } state_t;

    state_t state, next_state;

    // State Transition Logic
    always_ff @(posedge clk) begin
        if (reset) 
            state <= B; // Reset to state B
        else 
            state <= next_state;
    end

    // Next State Logic
    always_comb begin
        case (state)
            A: next_state = (in == 1'b0) ? B : A;
            B: next_state = (in == 1'b0) ? A : B;
            default: next_state = B;
        endcase
    end

    // Output Logic
    assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
