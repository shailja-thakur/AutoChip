module top_module (
	input a, 
	input b, 
	output q
);

	// Implement the combinational logic for the circuit
	assign q = (a & ~b) | (a & b);

endmodule
