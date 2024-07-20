module top_module (
	input [31:0] in,
	output [31:0] out
);
	
	// Instantiate the sub-module
	reverse_byte_order reverse_byte_order_1 (
		.in(in),
		.out(out)
	);
	
endmodule
module reverse_byte_order (
	input [31:0] in,
	output [31:0] out
);
	
	// Declare internal wires
	wire [7:0] byte0;
	wire [7:0] byte1;
	wire [7:0] byte2;
	wire [7:0] byte3;
	
	// Extract the individual bytes from the input vector
	assign byte0 = in[7:0];
	assign byte1 = in[15:8];
	assign byte2 = in[23:16];
	assign byte3 = in[31:24];
	
	// Reverse the order of the bytes
	assign out = {byte3, byte2, byte1, byte0};
	
endmodule
