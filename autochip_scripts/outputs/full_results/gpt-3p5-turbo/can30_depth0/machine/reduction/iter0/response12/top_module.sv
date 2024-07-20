module top_module (
  input [7:0] in,
  output parity
);
  
  // Parity calculation
  assign parity = ^in;
  
endmodule
