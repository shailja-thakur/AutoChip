module top_module (
	input a,
	input b,
	input sel,
	output out
);

	// Corrected code starts here
	
	assign out = (sel == 0) ? a : b;
	
	// Corrected code ends here

endmodule
