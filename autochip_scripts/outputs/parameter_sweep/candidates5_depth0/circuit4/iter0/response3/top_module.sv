module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	
	// Implement the combinational circuit
	assign q = (a & b & c) | (a & b & d) | (a & c & d) | (b & c & d);
	
endmodule
