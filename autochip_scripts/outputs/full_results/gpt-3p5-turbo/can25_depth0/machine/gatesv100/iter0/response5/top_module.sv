module top_module (
  input [99:0] in,
  output [98:0] out_both,
  output [99:1] out_any,
  output [99:0] out_different
);
  wire [99:0] in_shifted;
  
  assign in_shifted = {in[98:0], in[99]}; // Shifting the input signal by one bit
  
  assign out_both = in[98:0] & in_shifted[98:0]; // Bit-wise AND operation
  
  assign out_any = in[99:0] | in_shifted[99:1]; // Bit-wise OR operation
  
  assign out_different[0] = in[0] ^ in_shifted[99]; // Bit-wise XOR operation for the first bit of out_different
  
  assign out_different[99:1] = in[99:1] ^ in_shifted[98:0]; // Bit-wise XOR operation for the rest of out_different
endmodule
