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
  
  wire [4:0] concat_input;
  wire [2:0] concat_bit;
  
  // Concatenating inputs a, b, c, d, e, f
  assign concat_input = {a, b, c, d, e, f};
  
  // Assigning last two bits of concatenation to concat_bit
  assign concat_bit = concat_input[6:4];
  
  // Assigning values to the outputs
  assign w = {concat_input[4:0], concat_bit};
  assign x = {concat_input[5:0], concat_bit};
  assign y = {concat_input[6:0], concat_bit};
  assign z = {concat_input, concat_bit};
  
endmodule
