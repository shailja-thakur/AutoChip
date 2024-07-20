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

  wire [5:0] concat; // Change width from 7 to 6
  
  // Concatenating inputs a, b, c, d, e, f and 2'b11
  assign concat = {a, b, c, d, e, f}; // Remove 2'b11
  
  // Assigning the concatenated value to outputs w, x, y, z
  assign {w, x, y, z} = {concat, 2'b11}; // Add concatenation with 2'b11
  
endmodule
