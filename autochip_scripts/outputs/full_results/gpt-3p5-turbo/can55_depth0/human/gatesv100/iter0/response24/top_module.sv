module top_module (
  input [99:0] in,
  output [98:0] out_both,
  output [99:1] out_any,
  output [99:0] out_different
);
  
  // Internal wire declarations
  wire [98:0] in_shifted;
  wire [99:1] in_shifted_any;
  
  // Shift the input vector to the right by 1 bit
  assign in_shifted = in[98:0];
  assign in_shifted_any = in[99:1];
  
  // Logic for out_both
  assign out_both = in[98:0] & in_shifted;
  
  // Logic for out_any
  assign out_any = in[0] | in_shifted_any;
  
  // Logic for out_different
  assign out_different = in[98:0] ^ in[99] & {1'b0, out_different[99:1]};
  
endmodule
