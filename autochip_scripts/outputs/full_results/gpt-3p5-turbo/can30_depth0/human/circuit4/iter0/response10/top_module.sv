module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Declare an intermediate wire
	wire intermediate;
	
	// Implement the combinational circuit
	assign intermediate = (a & b) | (~c & d);
	assign q = ~intermediate;

endmodule
