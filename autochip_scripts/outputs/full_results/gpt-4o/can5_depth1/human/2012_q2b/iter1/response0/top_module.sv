module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // State encoding
    wire a = y[0];  // 000001
    wire b = y[1];  // 000010
    wire c = y[2];  // 000100
    wire d = y[3];  // 001000
    wire e = y[4];  // 010000
    wire f = y[5];  // 100000

    // Next state logic for Y1 (State B)
    assign Y1 = (a & w);  // If current state is A and w is 1, next state is B

    // Next state logic for Y3 (State D)
    assign Y3 = (b & ~w) | (c & ~w) | (d & ~w) | (e & ~w);  // If current state is B, C, D, or E and w is 0, next state is D

endmodule
