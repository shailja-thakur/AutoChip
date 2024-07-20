module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State declarations
    typedef enum reg [2:0] {
        A, B, C, S10, S11, S20, S21, S22
    } state_t;

    state_t state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case(state)
            A: if (s) next_state = B;
               else next_state = A;

            B: if (w) next_state = S11;
               else next_state = S10;

            C: if (w) next_state = S11;
               else next_state = S10;

            S10: if (w) next_state = S21;
                else next_state = S20;

            S11: if (w) next_state = S22;
                else next_state = S21;

            S20: next_state = B;

            S21: if (w) next_state = C;
                 else next_state = B;

            S22: if (w) next_state = B;
                 else next_state = C;

            default: next_state = A; // default case to avoid latches
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic (optional, based on state or other conditions)
    always @(*) begin
        z = (state == S20 || state == S21 || state == S22) ? 1 : 0;
    end

endmodule
