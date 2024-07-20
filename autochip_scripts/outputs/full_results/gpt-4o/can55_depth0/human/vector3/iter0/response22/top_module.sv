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

  // Concatenate all inputs and add two '1' bits in the LSB positions
  wire [31:0] concat_in = {a, b, c, d, e, f, 2'b11};
  
  // Assign the concatenated inputs to the outputs w, x, y, and z
  assign w = concat_in[31:24];
  assign x = concat_in[23:16];
  assign y = concat_in[15:8];
  assign z = concat_in[7:0];

endmodule
