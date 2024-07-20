module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	// Internal wire declarations
	wire w1;
	wire w2;
	
	// Assign wire values based on logical operations
	assign w1 = a & b;
	assign w2 = c & d;
	
	// Assign output values based on logical operations on wires
	assign out = w1 | w2;
	assign out_n = ~out;

endmodule
