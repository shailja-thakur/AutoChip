module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // Define the states
    typedef enum logic [1:0] {A, B} state_t;
    state_t state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) 
            state <= A;
        else 
            state <= next_state;
    end

    // State machine logic
    always_comb begin
        next_state = state; // default to hold value
        case (state)
            A: next_state = (x) ? B : A;
            B: next_state = B;
        endcase
    end

    // Output logic
    always_comb begin
        case (state)
            A: z = x ? 1 : 0;
            B: z = x ? 0 : 1;
            default: z = 0;
        endcase
    end

endmodule
