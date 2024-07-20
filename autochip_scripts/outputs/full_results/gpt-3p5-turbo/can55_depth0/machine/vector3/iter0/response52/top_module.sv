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
	// Define internal signals
	wire [7:0] concatenated;
	
	// Assign values to internal signals
	assign concatenated = {a, b, c, d, e, f, 2'b11};
	
	// Assign internal signals to outputs
	assign {w, x, y, z} = concatenated;
	
endmodule
