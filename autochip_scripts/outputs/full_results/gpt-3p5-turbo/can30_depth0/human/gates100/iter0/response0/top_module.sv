module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	// Declare 100 individual wires for the AND gate inputs
	wire [99:0] and_inputs;
	
	// Declare 100 individual wires for the OR gate inputs
	wire [99:0] or_inputs;
	
	// Declare 100 individual wires for the XOR gate inputs
	wire [99:0] xor_inputs;

	// Define the AND gate
	assign out_and = &and_inputs;

	// Connect the AND gate inputs to the module inputs
	assign and_inputs = in;

	// Define the OR gate
	assign out_or = |or_inputs;

	// Connect the OR gate inputs to the module inputs
	assign or_inputs = in;

	// Define the XOR gate
	assign out_xor = ^xor_inputs;

	// Connect the XOR gate inputs to the module inputs
	assign xor_inputs = in;
	
endmodule
