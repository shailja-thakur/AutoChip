module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);
    // Define state encoding
    typedef enum logic [0:0] {
        A = 1'b0,
        B = 1'b1
    } state_t;

    state_t state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;  // Initialize state to A on reset
        else
            state <= next_state;  // Transition to next state on clock edge
    end

    // Next state logic
    always_comb begin
        case (state)
            A: begin
                if (j)
                    next_state = B;  // Transition to B if j is high
                else
                    next_state = A;  // Remain in A if j is low
            end
            B: begin
                if (k)
                    next_state = A;  // Transition to A if k is high
                else
                    next_state = B;  // Remain in B if k is low
            end
            default: next_state = A;  // Default to A for safety
        endcase
    end

    // Output logic
    assign out = (state == B);  // Output is high when state is B, low when state is A

endmodule
