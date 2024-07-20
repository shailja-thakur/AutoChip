module top_module (
	input a,
	input b,
	input sel,
	output out
);

/* Corrected Code */

assign out = (sel == 0) ? a : b;

endmodule
