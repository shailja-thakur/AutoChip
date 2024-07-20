module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	// Define the internal wire signals
	wire w1, w2, w3, w4;

	// Implement the combinational logic
	assign w1 = ~b & ~c;
	assign w2 = ~a & ~d;
	assign w3 = w1 | w2;
	assign w4 = ~a & ~b & ~c & ~d;
	assign q = w3 & w4;
endmodule
