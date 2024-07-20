module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // Define state transitions for y[1] ((B state) and y[3] (D state)
    // y[1] is next state input for B
    // y[3] is next state input for D

    assign Y1 = (y[0] & w) | (y[5] & w); // Transition conditions to get to state B
    assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[3] & w) | (y[4] & ~w) | (y[5] & ~w); // Transition conditions to get to state D

endmodule
