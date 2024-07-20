module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    // Declaration of states
    typedef enum logic [1:0] {A, B, C, D} state_t;
    state_t state, next_state;

    // State transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (state)
            A: next_state = in ? B : A;
            B: next_state = in ? B : C;
            C: next_state = in ? D : A;
            D: next_state = in ? B : C;
            default: next_state = A;
        endcase
    end

    // Output logic
    always_comb begin
        if (state == D)
            out = 1;
        else
            out = 0;
    end

endmodule
