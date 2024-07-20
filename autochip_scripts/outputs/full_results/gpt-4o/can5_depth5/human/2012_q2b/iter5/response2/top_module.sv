module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

    // Logic for Y1 (state B)
    assign Y1 = (y[0] &  w);  // A to B transition

    // Logic for Y3 (state D)
    assign Y3 = (y[1] & ~w) |  // B to D
                (y[2] & ~w) |  // C to D
                (y[3] &  w)  |  // D to F
                (y[4] & ~w) |  // E to D
                (y[5] & ~w);   // F to D

endmodule
