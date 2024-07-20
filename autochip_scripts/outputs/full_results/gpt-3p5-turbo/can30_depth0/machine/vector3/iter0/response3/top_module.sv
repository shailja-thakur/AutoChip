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
  
  // Concatenation of input signals and constant value
  wire [41:0] concat;
  assign concat = {a, b, c, d, e, f, 2'b11};
  
  // Output signals
  assign {w, x, y, z} = concat;
  
endmodule
