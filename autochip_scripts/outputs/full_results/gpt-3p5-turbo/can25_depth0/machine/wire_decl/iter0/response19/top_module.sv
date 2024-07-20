module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	// Internal wires
	wire w1;
	wire w2;
	
	// Assign w1 the value of the logical AND of a and b
	assign w1 = a & b;
	
	// Assign w2 the value of the logical AND of c and d
	assign w2 = c & d;
	
	// Assign out the value of the logical OR of w1 and w2
	assign out = w1 | w2;
	
	// Assign out_n the logical NOT of out
	assign out_n = ~out;
	
endmodule
