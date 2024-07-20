module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    // State encoding
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // State transition and output logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;    // Initialize to state A on reset
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: if (j) next_state = B;
               else next_state = A;
            B: if (k) next_state = A;
               else next_state = B;
            default: next_state = A; // default state
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            A: out = 0;
            B: out = 1;
            default: out = 0;
        endcase
    end

endmodule
