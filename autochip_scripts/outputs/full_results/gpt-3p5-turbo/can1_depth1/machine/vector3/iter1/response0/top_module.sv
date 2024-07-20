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

  // Define the concatenation
  wire [43:0] concat;
  assign concat = {a, b, c, d, e, f, 7'b11};

  // Assign the outputs
  assign w = concat[43:36];
  assign x = concat[35:28];
  assign y = concat[27:20];
  assign z = concat[19:12];

endmodule
