module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Define internal wires
	wire w1, w2, w3, w4, w5, w6, w7, w8;
	
	// Define gates and connections
	assign w1 = ~a & ~b & ~c & ~d;
	assign w2 = ~a & ~b & ~c & d;
	assign w3 = ~a & ~b & c & d;
	assign w4 = ~a & ~b & c & ~d;
	assign w5 = ~a & b & ~c & d;
	assign w6 = ~a & b & ~c & ~d;
	assign w7 = ~a & b & c & ~d;
	assign w8 = a & ~b & c & d;
	assign q = w1 | w2 | w3 | w4 | w5 | w6 | w7 | w8;

endmodule
