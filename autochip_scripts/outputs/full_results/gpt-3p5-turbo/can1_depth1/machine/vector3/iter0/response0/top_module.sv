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
  wire [39:0] concat;
  assign concat = {a, b, c, d, e, f, 2'b11};

  // Assign the outputs
  assign w = concat[39:32];
  assign x = concat[31:24];
  assign y = concat[23:16];
  assign z = concat[15:8];

endmodule
