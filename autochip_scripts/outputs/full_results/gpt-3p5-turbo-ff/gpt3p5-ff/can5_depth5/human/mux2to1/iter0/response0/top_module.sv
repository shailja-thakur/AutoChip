module top_module (
	input a,
	input b,
	input sel,
	output out
);
	// Internal wire declarations
	wire out;

	// 2-to-1 MUX
	assign out = (sel == 0) ? a : b;
endmodule
