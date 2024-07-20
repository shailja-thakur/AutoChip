module top_module (
  input [7:0] in,
  output parity
);

  assign parity = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1] ^ in[0];
  
endmodule
