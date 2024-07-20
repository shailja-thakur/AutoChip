module top_module (
	input [2:0] in,
	output [1:0] out
);

	// Define intermediate wires for addition
	wire [1:0] sum;

	// Perform addition of input bits
	assign sum = in[2:1] + in[0];

	// Assign output bits
	assign out = sum;

endmodule
