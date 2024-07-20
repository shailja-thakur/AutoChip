module top_module (
	input [3:0] in,
	output out_and,
	output out_or,
	output out_xor
);
	// Define the intermediate signals
	wire [3:0] and_wire;
	wire [3:0] or_wire;
	wire [3:0] xor_wire;

	// Create the AND gate
	and #(.N(4)) u_and_gate (
		.in(in),
		.out(and_wire)
	);

	// Create the OR gate
	or #(.N(4)) u_or_gate (
		.in(in),
		.out(or_wire)
	);

	// Create the XOR gate
	xor #(.N(4)) u_xor_gate (
		.in(in),
		.out(xor_wire)
	);

	// Assign the outputs to the intermediate signals
	assign out_and = and_wire[3];
	assign out_or = or_wire[3];
	assign out_xor = xor_wire[3];

endmodule
