module top_module (
	input [31:0] in,
	output [31:0] out
);
	
	// Declare internal wires
	wire [7:0] byte0, byte1, byte2, byte3;
	
	// Split input into bytes
	assign byte0 = in[7:0];
	assign byte1 = in[15:8];
	assign byte2 = in[23:16];
	assign byte3 = in[31:24];
	
	// Reverse byte order
	assign out = {byte3, byte2, byte1, byte0};
	
endmodule
