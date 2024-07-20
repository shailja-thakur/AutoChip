module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

// Creating wires for intermediate signals
wire [99:0] and_inputs;
wire [99:0] or_inputs;
wire [99:0] xor_inputs;

// Connecting input signals to intermediate wires
assign and_inputs = in;
assign or_inputs = in;
assign xor_inputs = in;

// Connecting intermediate wires to output signals
assign out_and = &and_inputs;
assign out_or = |or_inputs;
assign out_xor = ^xor_inputs;

endmodule
