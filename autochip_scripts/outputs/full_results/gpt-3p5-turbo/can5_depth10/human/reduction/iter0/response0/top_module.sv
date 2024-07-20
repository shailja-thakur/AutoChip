module top_module (
  input [7:0] in,
  output parity
);

  wire [7:0] data_xor;
  reg par;
  
  // Calculate the XOR of all data bits
  assign data_xor[0] = in[0] ^ in[1];
  assign data_xor[1] = in[2] ^ in[3];
  assign data_xor[2] = in[4] ^ in[5];
  assign data_xor[3] = in[6] ^ in[7];
  
  reg parity_bit;
  
  // Calculate the parity bit
  assign parity_bit = data_xor[0] ^ data_xor[1] ^ data_xor[2] ^ data_xor[3];
  
  // Assign the parity bit to the output
  assign parity = parity_bit;
  
endmodule
