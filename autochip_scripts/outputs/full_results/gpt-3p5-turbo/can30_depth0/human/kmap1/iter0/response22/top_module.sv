module top_module(
  input a, 
  input b,
  input c,
  output out
);

  wire a_bar, b_bar, c_bar;

  assign a_bar = ~a;
  assign b_bar = ~b;
  assign c_bar = ~c;

  // Implementing the Karnaugh map
  assign out = (a_bar & b_bar) | (b_bar & c_bar) | (a_bar & c_bar);

endmodule
