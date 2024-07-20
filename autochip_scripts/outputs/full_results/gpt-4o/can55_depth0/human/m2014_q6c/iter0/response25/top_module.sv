module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);
    // One-hot encoding states: 
    // A = 000001, B = 000010, C = 000100, D = 001000, E = 010000, F = 100000
    // y[6:1]
    //   y[1] = A
    //   y[2] = B
    //   y[3] = C
    //   y[4] = D
    //   y[5] = E
    //   y[6] = F

    // Next state logic for Y2 (B state), Y2 is high when next state is B.
    assign Y2 = (y[1] & ~w); // From (A(0) --0--> B)

    // Next state logic for Y4 (D state), Y4 is high when next state is D.
    assign Y4 = (y[2] & w) | (y[3] & w) | (y[6] & w) | (y[1] & w); 
    // From (B(0) --1--> D), (C(0) --1--> D), (F(1) --1--> D), (A(0) --1--> A)

endmodule
