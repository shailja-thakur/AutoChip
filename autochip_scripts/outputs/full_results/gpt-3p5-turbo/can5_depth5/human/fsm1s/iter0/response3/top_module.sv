module top_module (
    input clk,
    input in,
    input reset,
    output out
);

reg [1:0] state;
reg out;

always @(posedge clk or posedge reset)
    if (reset)
        state <= 2'b10; // Reset state B
    else if (state == 2'b10) // State B
        if (in)
            state <= 2'b10; // Remain in state B
        else
            state <= 2'b01; // Transition to state A
    else if (state == 2'b01) // State A
        if (in)
            state <= 2'b01; // Remain in state A
        else
            state <= 2'b10; // Transition to state B

always @(*)
    case (state)
        2'b10: out = 1'b1; // State B, output 1
        2'b01: out = 1'b0; // State A, output 0
        default: out = 1'bx; // Default output, undefined

endmodule
