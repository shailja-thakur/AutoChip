module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Intermediate wire declarations
	wire w1, w2, w3, w4, w5, w6, w7, w8, w9, w10;

	// Gate-level logic
	assign w1 = (~a & ~b & ~c & ~d);  // Q = 0
	assign w2 = (~a & ~b & ~c & d);   // Q = 0
	assign w3 = (~a & ~b & c & ~d);   // Q = 0
	assign w4 = (~a & ~b & c & d);    // Q = 1
	assign w5 = (~a & b & ~c & ~d);   // Q = 1
	assign w6 = (~a & b & ~c & d);    // Q = 1
	assign w7 = (~a & b & c & ~d);    // Q = 1
	assign w8 = (~a & b & c & d);     // Q = 1
	assign w9 = (a & ~b & ~c & ~d);   // Q = 0
	assign w10 = (a & ~b & ~c & d);   // Q = 0

	// Output assignment
	assign q = (w1 | w2 | w3 | w4 | w5 | w6 | w7 | w8 | w9 | w10);

endmodule
