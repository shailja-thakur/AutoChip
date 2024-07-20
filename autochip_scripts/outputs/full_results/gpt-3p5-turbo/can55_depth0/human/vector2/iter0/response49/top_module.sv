module top_module (
	input [31:0] in,
	output [31:0] out
);

	// Declare internal wires
	wire [31:0] temp;

	// Reverse the byte order
	assign temp = {in[7:0], in[15:8], in[23:16], in[31:24]};

	// Assign the reversed byte order to the output
	assign out = temp;

endmodule
