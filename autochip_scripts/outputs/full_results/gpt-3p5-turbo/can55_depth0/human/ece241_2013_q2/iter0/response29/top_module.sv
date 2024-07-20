module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);
	// Create a wire to represent the output conditions
	wire logic_1;
	
	// Determine the output conditions for a logic-1 (2, 7, or 15)
	assign logic_1 = (a && !b && c && d) || (!a && b && c && d) || (a && b && c && d);
	
	// Determine the output conditions for a logic-0 (0, 1, 4, 5, 6, 9, 10, 13, or 14)
	assign out_sop = !((!a && !b && !c && !d) || (a && !b && !c && !d) || (!a && b && !c && !d) || (a && b && !c && !d) || (!a && !b && c && !d) || (a && !b && c && !d) || (!a && b && c && !d) || (a && b && c && !d) || (!a && !b && !c && d) || (a && !b && !c && d) || (!a && b && !c && d) || (!a && !b && c && d) || (a && !b && c && d) || (!a && b && c && d) || (a && b && c && d));
	
	// Determine the output conditions for a logic-0 in minimum product-of-sums form
	assign out_pos = !(logic_1);
	
endmodule
