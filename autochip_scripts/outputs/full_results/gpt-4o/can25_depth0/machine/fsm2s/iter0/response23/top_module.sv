module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // Define states
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: if (j) next_state = B;
               else next_state = A;
            B: if (k) next_state = A;
               else next_state = B;
            default: next_state = A;  // Default to state A
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset) state <= A;  // Initialize to state A
        else state <= next_state;
    end

    // Output logic
    always @(*) begin
        if (state == B) out = 1;
        else out = 0;
    end

endmodule
