module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Declare internal wire variables
	wire w1, w2, w3, w4, w5;

	// Assign internal wire values
	assign w1 = (~c & d);
	assign w2 = (~a & b & ~c & ~d);
	assign w3 = (b & ~c & d);
	assign w4 = (a & ~b & c & ~d);
	assign w5 = (~a & b & c & d);

	// Assign output value
	assign q = (w1 | w2 | w3 | w4 | w5);

endmodule
