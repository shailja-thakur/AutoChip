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

    // Sequential logic for state transition and output
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
            out <= 0;
        end else begin
            state <= next_state;
            out <= (state == B) ? 1 : 0;
        end
    end

    // Combinational logic to determine next state
    always @(*) begin
        case (state)
            A: next_state = (j) ? B : A;
            B: next_state = (k) ? A : B;
            default: next_state = A;  // Should never occur
        endcase
    end

endmodule
