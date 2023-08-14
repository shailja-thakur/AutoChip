module top_module (
    input wire in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out);

    parameter A = 0, B = 1, C = 2, D = 3;

    // State transition logic: Derive an equation for each state flip-flop.
    assign next_state[A] = (in == 0) ? B : A;
    assign next_state[B] = (in == 0) ? C : B;
    assign next_state[C] = (in == 0) ? A : D;
    assign next_state[D] = (in == 0) ? C : B;

    // Output logic: 
    assign out = (in == 0) ? 0 : 1;

endmodule