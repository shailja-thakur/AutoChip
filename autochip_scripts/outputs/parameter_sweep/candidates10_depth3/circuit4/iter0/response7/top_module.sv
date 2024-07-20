module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	// Implement the circuit
	assign q = (a & b & ~c) | (a & b & d) | (a & ~b & c) | (a & ~b & ~c & d) | (~a & b & c);

endmodule
