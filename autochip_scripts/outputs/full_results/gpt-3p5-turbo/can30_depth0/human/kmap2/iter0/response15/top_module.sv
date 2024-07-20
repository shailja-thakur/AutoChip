module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

	// Implementing the truth table directly
	assign out = !((!a && !b && c) || (!a && b && !c) || (a && !b && c) || (a && b && d));
	
endmodule
