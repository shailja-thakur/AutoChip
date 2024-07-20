module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n
);

	// Declare internal wires
	wire w1;
	wire w2;

	// Assign w1 to be the AND of a and b
	assign w1 = a & b;

	// Assign w2 to be the AND of c and d
	assign w2 = c & d;

	// Assign out to be the OR of w1 and w2
	assign out = w1 | w2;

	// Assign out_n to be the NOT of out
	assign out_n = ~out;

endmodule
