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
 
// Concatenate the input vectors
wire [29:0] concatenated_vector;
assign concatenated_vector = {a, b, c, d, e, f};

// Create the output vectors with concatenated_vector followed by two 1 bits in LSB positions
assign {w, x, y, z} = {concatenated_vector, 2'b11};

endmodule
