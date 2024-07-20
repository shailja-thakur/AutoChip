module top_module (
	input [31:0] in,
	output [31:0] out
);

	// Define internal wire for byte reversal
	wire [7:0] reversed_byte;

	// Reverse order of each byte in the input vector
	assign reversed_byte[7:0] = in [31:24];
	assign reversed_byte[15:8] = in [23:16];
	assign reversed_byte[23:16] = in [15:8];
	assign reversed_byte[31:24] = in [7:0];

	// Concatenate reversed bytes to form the output vector
	assign out = {reversed_byte[31:24], reversed_byte[23:16], reversed_byte[15:8], reversed_byte[7:0]};

endmodule
