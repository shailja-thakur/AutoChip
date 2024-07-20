module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    // State encoding
    typedef enum reg {A, B} state_t;
    reg state, next_state;

    // State transition logic
    always @* begin
        case (state)
            A: if (j) next_state = B;
               else next_state = A;
            B: if (k) next_state = A;
               else next_state = B;
            default: next_state = A;  // Default to state A
        endcase
    end

    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;  // Set state to A on reset
        else
            state <= next_state;
    end

    // Output logic
    assign out = (state == B);

endmodule
