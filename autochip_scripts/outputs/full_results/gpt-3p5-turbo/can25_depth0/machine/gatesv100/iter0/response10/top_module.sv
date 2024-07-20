module top_module (
  input [99:0] in,
  output [98:0] out_both,
  output [99:1] out_any,
  output [99:0] out_different
);

  wire [98:0] shift_in;           // Wire to hold the shifted input signal

  // Generate the shifted input signal
  assign shift_in[98:0] = in[99:1];
  
  // Perform bit-wise AND operation to generate out_both
  assign out_both = in[98:0] & shift_in;
  
  // Perform bit-wise OR operation to generate out_any
  assign out_any = in | shift_in;
  
  // Perform bit-wise XOR operation to generate out_different
  assign out_different[0] = in[0] ^ shift_in[98];
  assign out_different[99:1] = in[99:1] ^ shift_in[98:0];

endmodule
