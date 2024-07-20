module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	wire w1;  // wire for the logical AND of a and b
	wire w2;  // wire for the logical AND of c and d

	assign w1 = a & b;  // assign the value of the logical AND of a and b to w1
	assign w2 = c & d;  // assign the value of the logical AND of c and d to w2

	assign out = w1 | w2;  // assign the value of the logical OR of w1 and w2 to out
	assign out_n = ~out;  // assign the logical NOT of out to out_n

endmodule
