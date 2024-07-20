module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	// Declare internal wires
	wire w1;
	wire w2;

	// Assign values to wires
	assign w1 = a & b;
	assign w2 = c & d;

	// Assign values to outputs
	assign out = w1 | w2;
	assign out_n = ~out;

endmodule
