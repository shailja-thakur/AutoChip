module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Declare internal wires
	wire w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14;

	// Assign internal wires
	assign w1 = ~a & ~b & ~c & ~d;
	assign w2 = ~a & ~b & ~c & d;
	assign w3 = ~a & ~b & c & ~d;
	assign w4 = ~a & ~b & c & d;
	assign w5 = ~a & b & ~c & ~d;
	assign w6 = ~a & b & ~c & d;
	assign w7 = ~a & b & c & ~d;
	assign w8 = ~a & b & c & d;
	assign w9 = a & ~b & ~c & ~d;
	assign w10 = a & ~b & ~c & d;
	assign w11 = a & ~b & c & ~d;
	assign w12 = a & ~b & c & d;
	assign w13 = a & b & ~c & ~d;
	assign w14 = a & b & ~c & d;

	// Generate the output
	assign q = w1 | w2 | w3 | w4 | w5 | w6 | w7 | w8 | w9 | w10 | w11 | w12 | w13 | w14;

endmodule
