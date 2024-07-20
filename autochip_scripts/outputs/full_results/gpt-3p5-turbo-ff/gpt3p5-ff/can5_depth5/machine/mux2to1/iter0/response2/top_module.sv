module top_module (
	input a,
	input b,
	input sel,
	output out
);
	
	// Assign the output based on the value of sel
	assign out = (sel == 1'b1) ? b : a;
	
endmodule
