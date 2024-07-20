module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	// Intermediate wires
	wire w1;
	wire w2;

	// Logic
	assign w1 = a & b;
	assign w2 = c & d;
	assign out = w1 | w2;
	assign out_n = ~out;

endmodule
