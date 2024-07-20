module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define the states
    parameter A = 1'b0;
    parameter B = 1'b1;

    // Current and next state registers
    reg state, next_state;

    // Combinational logic for next state
    always @(*) begin
        case (state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
            default: next_state = A; // Default state
        endcase
    end

    // Sequential logic for state transition and reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B; // Reset state to B
        else
            state <= next_state; // State transition
    end

    // Output logic
    always @(*) begin
        out = (state == B) ? 1'b1 : 1'b0;
    end

endmodule
