module top_module (
  input [99:0] in,
  output [98:0] out_both,
  output [99:1] out_any,
  output [99:0] out_different
);

  wire [98:0] in_right;
  wire [98:0] in_left;
  
  assign in_right[0] = in[1];
  assign in_right[1:98] = in[2:99];
  
  assign in_left[98] = in[0];
  assign in_left[0:97] = in[1:98];
  
  assign out_both = in[98:0] & in_left;
  
  assign out_any[98] = in[99] | in[98];
  assign out_any[2:0] = in[2:0] | in_left[0:2];
  assign out_any[99:3] = in[99:3] | in_right[99:3];
  
  assign out_different[98] = in[98] ^ in[99];
  assign out_different[97:0] = in[97:0] ^ in_left[97:0];
  assign out_different[99] = in[99] ^ in[0];

endmodule
