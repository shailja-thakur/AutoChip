module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	// add a delay in the circuit to ensure all inputs have settled before calculation starts
	// use #1 to add a 1ns delay
	#1

	assign q = (a & b) | (c & d);
endmodule
