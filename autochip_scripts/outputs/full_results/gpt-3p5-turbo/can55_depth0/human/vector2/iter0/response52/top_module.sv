module top_module (
	input [31:0] in,
	output [31:0] out
);
	// Wire declaration
	wire [31:0] reversed_byte;

	// Reversing the byte order
	assign reversed_byte = {in[7:0], in[15:8], in[23:16], in[31:24]};

	// Assigning the reversed byte to output
	assign out = reversed_byte;

endmodule
