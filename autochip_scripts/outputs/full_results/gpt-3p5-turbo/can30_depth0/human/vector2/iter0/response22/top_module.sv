module top_module (
	input [31:0] in,
	output [31:0] out
);

	// Declare internal signals
	wire [7:0] data_byte[3:0];
	
	// Split 32-bit input into four 8-bit data bytes
	assign data_byte[0] = in[7:0];
	assign data_byte[1] = in[15:8];
	assign data_byte[2] = in[23:16];
	assign data_byte[3] = in[31:24];
	
	// Reverse the byte order
	assign out = {data_byte[3], data_byte[2], data_byte[1], data_byte[0]};
	
endmodule
