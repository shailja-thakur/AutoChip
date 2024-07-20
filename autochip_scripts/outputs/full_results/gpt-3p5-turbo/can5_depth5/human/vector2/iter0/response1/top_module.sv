module top_module (
	input [31:0] in,
	output [31:0] out
);

	// Define internal wires
	wire [7:0] byte0_i, byte1_i, byte2_i, byte3_i;
	wire [7:0] byte0_o, byte1_o, byte2_o, byte3_o;

	// Extract bytes from input
	assign byte0_i = in[7:0];
	assign byte1_i = in[15:8];
	assign byte2_i = in[23:16];
	assign byte3_i = in[31:24];

	// Reverse the byte order
	assign byte0_o = byte3_i;
	assign byte1_o = byte2_i;
	assign byte2_o = byte1_i;
	assign byte3_o = byte0_i;

	// Concatenate the reversed bytes to form the output
	assign out = {byte0_o, byte1_o, byte2_o, byte3_o};

endmodule
