module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

	// Define intermediate signals
	wire logic_2, logic_7, logic_15; // Signals representing 2, 7, 15 inputs
	wire logic_0, logic_1, logic_4, logic_5, logic_6, logic_9, logic_10, logic_13, logic_14; // Signals representing 0, 1, 4, 5, 6, 9, 10, 13, 14 inputs

	// Assign intermediate signals
	assign logic_2 = (a == 0) && (b == 0) && (c == 1) && (d == 0);
	assign logic_7 = (a == 0) && (b == 1) && (c == 1) && (d == 1);
	assign logic_15 = (a == 1) && (b == 1) && (c == 1) && (d == 1);

	assign logic_0 = (a == 0) && (b == 0) && (c == 0) && (d == 0);
	assign logic_1 = (a == 0) && (b == 0) && (c == 0) && (d == 1);
	assign logic_4 = (a == 0) && (b == 1) && (c == 0) && (d == 0);
	assign logic_5 = (a == 0) && (b == 1) && (c == 0) && (d == 1);
	assign logic_6 = (a == 0) && (b == 1) && (c == 1) && (d == 0);
	assign logic_9 = (a == 1) && (b == 0) && (c == 0) && (d == 1);
	assign logic_10 = (a == 1) && (b == 0) && (c == 1) && (d == 0);
	assign logic_13 = (a == 1) && (b == 1) && (c == 0) && (d == 1);
	assign logic_14 = (a == 1) && (b == 1) && (c == 1) && (d == 0);

	// Define outputs in SOP and POS form
	assign out_sop = logic_2 | logic_7 | logic_15; // Minimum sum-of-products form
	assign out_pos = logic_0 & logic_1 & logic_4 & logic_5 & logic_6 & logic_9 & logic_10 & logic_13 & logic_14; // Minimum product-of-sums form

endmodule
