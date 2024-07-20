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
  wire [29:0] concatenated_input;
  assign concatenated_input = {a, b, c, d, e, f};

  // Add two 1 bits to the LSB positions of the concatenated input
  wire [31:0] output_with_ones;
  assign output_with_ones = {concatenated_input, 2'b11};

  // Split up the output into four 8-bit vectors
  assign {w, x, y, z} = output_with_ones;

endmodule
