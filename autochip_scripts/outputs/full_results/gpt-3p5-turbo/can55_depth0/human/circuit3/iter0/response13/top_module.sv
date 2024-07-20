module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	// Define internal signals
	wire w1, w2, w3, w4, w5, w6, w7, w8;

	// Implement the circuit
	assign w1 = a | b;
	assign w2 = b & c;
	assign w3 = c & d;
	assign w4 = a ^ b;
	assign w5 = ~c;
	assign w6 = w1 & w2;
	assign w7 = w3 | w4;
	assign w8 = w5 & w7;
	assign q = w6 | w8;

endmodule
