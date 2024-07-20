module top_module (
	input a,
	input b,
	input sel,
	output out
);

	// Logic for 2-to-1 multiplexer
	assign out = (sel == 0) ? a : b;
	
endmodule
