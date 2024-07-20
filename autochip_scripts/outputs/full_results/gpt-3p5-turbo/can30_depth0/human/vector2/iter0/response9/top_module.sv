module top_module (
	input [31:0] in,
	output [31:0] out
);
	
	// Define wires to connect to individual bits of the input and output vectors
	wire [7:0] in_byte0, in_byte1, in_byte2, in_byte3;
	wire [7:0] out_byte0, out_byte1, out_byte2, out_byte3;
	
	// Split the input vector into individual bytes
	assign in_byte0 = in[7:0];
	assign in_byte1 = in[15:8];
	assign in_byte2 = in[23:16];
	assign in_byte3 = in[31:24];
	
	// Reverse the byte order
	assign out_byte0 = in_byte3;
	assign out_byte1 = in_byte2;
	assign out_byte2 = in_byte1;
	assign out_byte3 = in_byte0;
	
	// Concatenate the reversed bytes to form the output vector
	assign out = {out_byte3, out_byte2, out_byte1, out_byte0};
	
endmodule
