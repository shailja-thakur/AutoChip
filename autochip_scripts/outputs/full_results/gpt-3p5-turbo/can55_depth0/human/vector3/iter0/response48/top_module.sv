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

	// Internal signal declarations
	reg [29:0] concat_input;
	
	// Assign input vectors to the concatenated internal signal
	assign concat_input = {a, b, c, d, e, f};
	
	// Assign the concatenated input signal followed by two 1 bits to the output vectors
	assign {w, x, y, z} = {concat_input, 2'b11};

endmodule
