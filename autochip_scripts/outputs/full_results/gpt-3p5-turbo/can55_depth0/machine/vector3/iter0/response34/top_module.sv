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
  wire [7:0] concat;
  
  assign concat = {a, b, c, d, e, f, 2'b11}; // concatenation of inputs and 2'b11
  
  assign w = concat[7:0]; // first 8 bits of concatenation assigned to w
  assign x = concat[15:8]; // next 8 bits of concatenation assigned to x
  assign y = concat[23:16]; // next 8 bits of concatenation assigned to y
  assign z = concat[31:24]; // last 8 bits of concatenation assigned to z
endmodule
