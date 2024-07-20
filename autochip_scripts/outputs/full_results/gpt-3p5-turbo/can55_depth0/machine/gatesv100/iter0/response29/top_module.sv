module top_module (
  input [99:0] in,
  output [98:0] out_both,
  output [99:1] out_any,
  output [99:0] out_different
);

  assign out_both = in[98:0] & in[99:1]; // Perform bit-wise AND operation
  
  assign out_any = in[99:0] | (in[99] << 99); // Perform bit-wise OR operation
  
  assign out_different = {in[0] ^ in[99], in[99:1] ^ in[98:0]}; // Perform bit-wise XOR operation
endmodule
