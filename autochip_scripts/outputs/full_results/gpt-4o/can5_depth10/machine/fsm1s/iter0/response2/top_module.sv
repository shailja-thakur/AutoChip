module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    // State declaration
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;

    // Combinational logic block for next state logic
    always @(*) begin
        case (state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
            default: next_state = A; // Default state
        endcase
    end

    // Sequential logic block for state transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B; // Initial state on reset
        else
            state <= next_state;
    end

    // Output logic
    always @(state) begin
        out = (state == B) ? 1'b1 : 1'b0;
    end

endmodule
