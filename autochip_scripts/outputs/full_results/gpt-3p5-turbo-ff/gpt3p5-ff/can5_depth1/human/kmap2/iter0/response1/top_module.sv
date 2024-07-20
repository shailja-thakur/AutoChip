module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

	// Define the intermediate signals
	wire w1, w2, w3, w4, w5, w6;

	// Implement the circuit using gates
	assign w1 = a & (b | c);
	assign w2 = (a | b) & ~(c & d);
	assign w3 = ~a & b & c;
	assign w4 = (a & b) | (~c & d);
	assign w5 = w1 & w2;
	assign w6 = w3 | w4;
	assign out = w5 ^ w6;

endmodule
