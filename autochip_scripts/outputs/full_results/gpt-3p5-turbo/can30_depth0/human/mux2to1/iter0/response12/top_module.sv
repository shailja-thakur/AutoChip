module top_module (
	input a,
	input b,
	input sel,
	output out
);

	// Declare internal wires
	wire out_wire;

	// Implementing the logic
	assign out_wire = (sel == 0) ? a : b;

	// Output assignment
	assign out = out_wire;

endmodule
