module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	// Declare intermediate wires
	wire w1, w2;

	// Assigning wires
	assign w1 = a & b;
	assign w2 = c & d;

	// Assigning outputs
	assign out = w1 | w2;
	assign out_n = ~out;

endmodule
