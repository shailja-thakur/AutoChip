module top_module(
  input [2:0] a, 
  input [2:0] b, 
  output [2:0] out_or_bitwise,
  output out_or_logical,
  output [5:0] out_not
);
  wire [2:0] bitwise_or;
  wire logical_or;
  wire [5:0] bitwise_not_a;
  wire [5:0] bitwise_not_b;
  
  assign bitwise_or = a | b;
  assign logical_or = (a != 0) || (b != 0);
  assign bitwise_not_a = ~a;
  assign bitwise_not_b = ~b;
  
  assign out_or_bitwise = bitwise_or;
  assign out_or_logical = logical_or;
  assign out_not = {bitwise_not_b, bitwise_not_a};
  
endmodule
