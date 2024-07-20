module top_module (
  input [3:0] in,
  output [2:0] out_both,
  output [3:1] out_any,
  output [3:0] out_different
);
  // Assign the output for the bitwise AND operation
  assign out_both = in[2:0] & in[3:1];
  
  // Assign the output for the bitwise OR operation
  assign out_any = in[2:0] | in[3:1];
  
  // Assign the output for the bitwise XOR operation with an exception for the input bit 0
  assign out_different = in ^ (in[3:1] & 4'b1110);
endmodule
