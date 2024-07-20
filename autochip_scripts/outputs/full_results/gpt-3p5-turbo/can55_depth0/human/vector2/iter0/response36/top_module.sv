module top_module (
	input [31:0] in,
	output [31:0] out
);

	// Define wire for reversed output
	wire [31:0] reversed_output;

	// Reverse the byte order of the 32-bit input vector
	assign reversed_output = {in[7:0], in[15:8], in[23:16], in[31:24]};

	// Assign the reversed output to the output port
	assign out = reversed_output;

endmodule
