module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

	// Assign the output signal based on the logic function
	assign out = (c & ~b) | (d & ~a) | (a & c & d) | (b & c & d);
	
endmodule
