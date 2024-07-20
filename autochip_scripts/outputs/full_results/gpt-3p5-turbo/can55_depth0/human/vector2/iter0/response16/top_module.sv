module top_module (
	input [31:0] in,
	output [31:0] out
);

	// Wire declaration
	wire [7:0] in_byte_0;
	wire [7:0] in_byte_1;
	wire [7:0] in_byte_2;
	wire [7:0] in_byte_3;
	wire [7:0] out_byte_0;
	wire [7:0] out_byte_1;
	wire [7:0] out_byte_2;
	wire [7:0] out_byte_3;

	// Reversing the byte order
	assign in_byte_0 = in[7:0];
	assign in_byte_1 = in[15:8];
	assign in_byte_2 = in[23:16];
	assign in_byte_3 = in[31:24];

	// Assigning the reversed byte order to the output
	assign out = {out_byte_3, out_byte_2, out_byte_1, out_byte_0};
	
endmodule
