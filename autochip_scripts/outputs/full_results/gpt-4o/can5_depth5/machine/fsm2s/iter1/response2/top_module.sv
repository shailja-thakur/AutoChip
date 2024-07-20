module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // State declaration
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // State transition with synchronous reset
    always @(posedge clk) begin
        if (reset)
            state <= A; // On reset, set state to A
        else
            state <= next_state; // Otherwise transition to next state
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: if (j) next_state = B; else next_state = A;
            B: if (k) next_state = A; else next_state = B;
            default: next_state = A;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        case (state)
            A: out = 0;
            B: out = 1;
            default: out = 0;
        endcase
    end

endmodule
