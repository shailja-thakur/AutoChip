module top_module (
	input a,
	input b,
	input sel,
	output out
);
	// Declaration of wire to connect inputs and outputs
	wire out;

	// One-bit wide, 2-to-1 multiplexer
	assign out = (sel == 1'b0) ? a : b;
endmodule
