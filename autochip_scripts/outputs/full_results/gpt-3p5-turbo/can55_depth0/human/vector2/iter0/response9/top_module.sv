module top_module (
	input [31:0] in,
	output [31:0] out
);

	// Declare a wire to store the reversed byte order
	wire [31:0] reversed;

	// Reverse the byte order
	assign reversed[31:24] = in[7:0];
	assign reversed[23:16] = in[15:8];
	assign reversed[15:8] = in[23:16];
	assign reversed[7:0] = in[31:24];

	// Assign the reversed byte order to the output
	assign out = reversed;

endmodule
