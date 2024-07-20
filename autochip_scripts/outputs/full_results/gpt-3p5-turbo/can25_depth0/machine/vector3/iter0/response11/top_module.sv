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
  // Concatenate a, b, c, d, e, f with 2'b11
  wire [21:0] concatenated_input;
  assign concatenated_input = {a, b, c, d, e, f, 2'b11};

  // Split the concatenated input into w, x, y, z
  assign {w, x, y, z} = concatenated_input;
endmodule
