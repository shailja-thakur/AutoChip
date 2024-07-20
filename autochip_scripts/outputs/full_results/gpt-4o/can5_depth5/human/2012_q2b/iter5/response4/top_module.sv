module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

    // Logic for Y1
    assign Y1 = (y[0] &  w);  // A to B

    // Logic for Y3
    assign Y3 = (y[1] & ~w) |  // B to D
                (y[2] & ~w) |  // C to D
                (y[3] & (w | ~w));  // D to A on 0; to F on 1 (remains true for both)
endmodule
