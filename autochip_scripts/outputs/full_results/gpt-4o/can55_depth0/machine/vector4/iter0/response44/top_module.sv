module top_module (
	input [7:0] in,
	output [31:0] out
);

	assign out = {in, in, in, in};  // Replicate in 4 times to form a 32-bit output

endmodule
