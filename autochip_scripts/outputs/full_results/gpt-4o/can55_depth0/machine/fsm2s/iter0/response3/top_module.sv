module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // State declaration
    typedef enum logic {A, B} state_t;
    state_t state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;  // Initialize state to A on reset
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (state)
            A: if (j) next_state = B;
               else next_state = A;
            B: if (k) next_state = A;
               else next_state = B;
            default: next_state = A;  // Default state
        endcase
    end

    // Output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            out <= 0;
        else
            out <= (state == B);
    end

endmodule
