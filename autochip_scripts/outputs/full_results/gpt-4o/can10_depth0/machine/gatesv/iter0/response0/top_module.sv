module top_module (
  input [3:0] in,
  output [2:0] out_both,
  output [3:0] out_any,
  output [3:0] out_different
);

  assign out_both = in[2:0] & in[3:1];
  assign out_any = in[2:0] | in[3:1];
  assign out_any[3] = in[3];  // To ensure 4-bit wide output, retain the MSB from input directly
  assign out_different = in ^ {in[2:0], in[0]};  // Specific bitwise XOR operation with bit 0 exception
  
endmodule
