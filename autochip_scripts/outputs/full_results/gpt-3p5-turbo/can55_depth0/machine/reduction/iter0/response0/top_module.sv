module top_module (
	input [7:0] in,
	output parity
);

	// Declare internal wires
	wire [7:0] XOR_result;
	wire [7:0] AND_result;
	wire [7:0] NOT_result;
	wire [7:0] OR_result;

	// Calculate XOR of all input bits
	assign XOR_result = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];

	// Invert each input bit
	assign NOT_result = ~in;

	// AND NOT_result with input
	assign AND_result = NOT_result & in;

	// OR all bits of AND_result
	assign OR_result = OR(AND_result);

	// Assign the final parity result
	assign parity = ~OR_result;

endmodule
