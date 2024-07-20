module top_module (
	input [7:0] in,
	output [7:0] out
);

	// Create wire for each bit of the input vector
	wire [7:0] reversed;

	// Assign the reversed order bits to the wire
	assign reversed = {in[0], in[1], in[2], in[3], in[4], in[5], in[6], in[7]};

	// Assign the wire value to the output
	assign out = reversed;

endmodule
