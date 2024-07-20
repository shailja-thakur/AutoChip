module top_module (
	input [4:0] a,
	input [4:0] b,
	input [4:0] c,
	input [4:0] d,
	input [4:0] e,
	input [4:0] f,
	output [7:0] w,
	output [7:0] x,
	output [7:0] y,
	output [7:0] z
);

	// Concatenate input vectors
	wire [29:0] concat_vector;
	assign concat_vector = {a, b, c, d, e, f};
	
	// Add two 1 bits in LSB positions
	wire [31:0] output_vector;
	assign output_vector = {concat_vector, 2'b11};

	// Split output vector
	assign {w, x, y, z} = output_vector;

endmodule
