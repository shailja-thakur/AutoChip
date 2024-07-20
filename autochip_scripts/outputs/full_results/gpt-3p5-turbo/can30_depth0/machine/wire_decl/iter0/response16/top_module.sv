module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	wire w1, w2;  // Declare the two wires

	assign w1 = a & b;  // Assign w1 to the logical AND of a and b
	assign w2 = c & d;  // Assign w2 to the logical AND of c and d

	assign out = w1 | w2;  // Assign out to the logical OR of w1 and w2
	assign out_n = ~out;  // Assign out_n to the logical NOT of out

endmodule
