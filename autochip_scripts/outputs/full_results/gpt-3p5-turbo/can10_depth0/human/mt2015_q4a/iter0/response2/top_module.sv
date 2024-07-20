module top_module(
  input x,
  input y,
  output z);

  // Instantiate xor gate
  wire xor_out;
  xor u_xor(.a(x), .b(y), .z(xor_out));
  
  // AND gate
  assign z = xor_out & x;
  
endmodule
