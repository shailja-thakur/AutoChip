module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // States
    typedef enum logic [1:0] {
        A = 1'b0,
        B = 1'b1
    } state_t;

    state_t state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (state)
            A: next_state = (j) ? B : A;
            B: next_state = (k) ? A : B;
            default: next_state = A; // default to A for safety
        endcase
    end

    // Output logic
    always_comb begin
        case (state)
            A: out = 1'b0;
            B: out = 1'b1;
            default: out = 1'b0; // default to 0 for safety
        endcase
    end

endmodule
