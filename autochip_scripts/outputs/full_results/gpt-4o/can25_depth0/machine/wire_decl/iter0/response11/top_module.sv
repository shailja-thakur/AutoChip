module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	// Internal wires
	wire w1, w2;

	// Assign wire values
	assign w1 = a & b;
	assign w2 = c & d;

	// Assign output values
	assign out = w1 | w2;
	assign out_n = ~out;
	
endmodule
