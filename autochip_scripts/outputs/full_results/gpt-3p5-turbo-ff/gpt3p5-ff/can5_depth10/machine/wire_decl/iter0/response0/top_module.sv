module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	// Declare intermediate wires
	wire w1, w2;

	// Assign the value of w1 as the logical AND of a and b
	assign w1 = a & b;
  
	// Assign the value of w2 as the logical AND of c and d
	assign w2 = c & d;

	// Assign the value of out as the logical OR of w1 and w2
	assign out = w1 | w2;

	// Assign the value of out_n as the logical NOT of out
	assign out_n = ~out;
	
endmodule
