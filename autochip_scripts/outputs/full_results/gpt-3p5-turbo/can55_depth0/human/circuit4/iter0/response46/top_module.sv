module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Define internal wire signals
	wire w1, w2, w3, w4, w5;

	// Implement the combinational logic
	assign w1 = a & b;
	assign w2 = ~c & d;
	assign w3 = w1 | w2;
	assign w4 = w3 & ~d;
	assign w5 = w4 | (a & ~c);
	assign q = w5;

endmodule
