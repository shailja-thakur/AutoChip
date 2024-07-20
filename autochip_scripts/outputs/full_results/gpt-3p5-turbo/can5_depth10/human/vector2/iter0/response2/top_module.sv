module top_module (
	input [31:0] in,
	output [31:0] out
);

	// Define a wire to store the reversed byte order
	wire [31:0] reversed_byte_order;

	// Reverse the byte order using concatenation
	assign reversed_byte_order = {in[7:0], in[15:8], in[23:16], in[31:24]};

	// Assign the reversed byte order to the output
	assign out = reversed_byte_order;

endmodule
