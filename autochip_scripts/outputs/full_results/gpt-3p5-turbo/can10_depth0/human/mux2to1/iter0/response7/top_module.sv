module top_module (
  input a,
  input b,
  input sel,
  output out
);

  // One-bit wide, 2-to-1 multiplexer
  assign out = (sel == 0) ? a : b;
  
endmodule
