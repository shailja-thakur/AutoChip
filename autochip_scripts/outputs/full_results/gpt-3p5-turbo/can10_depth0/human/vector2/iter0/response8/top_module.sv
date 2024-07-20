module top_module (
	input [31:0] in,
	output [31:0] out
);
	// Wire declaration for intermediate signals
	wire [7:0] in_byte[3:0];
	wire [7:0] out_byte[3:0];
	
	// Latching input into byte-wise signals
	assign in_byte[3] = in[31:24];
	assign in_byte[2] = in[23:16];
	assign in_byte[1] = in[15:8];
	assign in_byte[0] = in[7:0];
	
	// Reversing the byte order
	assign out_byte[3] = in_byte[0];
	assign out_byte[2] = in_byte[1];
	assign out_byte[1] = in_byte[2];
	assign out_byte[0] = in_byte[3];
	
	// Concatenating reversed bytes into output
	assign out = {out_byte[3], out_byte[2], out_byte[1], out_byte[0]};
endmodule
