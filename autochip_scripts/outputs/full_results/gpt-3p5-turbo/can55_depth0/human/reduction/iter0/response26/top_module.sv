module top_module (
    input [7:0] in,
    output parity
);
  
  // Intermediate wire to hold XOR of in
  wire xor_out;
  
  // Parity bit
  assign parity = xor_out;
  
  // XOR gate to compute parity
  assign xor_out = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];
 
endmodule
