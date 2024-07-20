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
	// Define internal wire
	wire [4:0] concat_input;
	wire [1:0] concat_last_input;
	
	// Concatenate inputs
	assign concat_input = {a, b, c, d, e, f};
	assign concat_last_input = 2'b11;
	
	// Assign outputs
	assign {concat_input, concat_last_input} = {w, x, y, z};

endmodule
