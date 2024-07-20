module top_module (
  input a, 
  input b,
  input c,
  input d,
  output out
);

wire w1, w2, w3, w4, w5, w6, w7, w8;

// Implement the Karnaugh map logic
and (w1, a, b);
and (w2, ~c, d);
and (w3, ~a, ~b, c, d);
and (w4, ~a, b, ~c, d);
and (w5, ~a, c, d);
and (w6, a, b, ~d);
and (w7, a, ~b, c, d);
and (w8, a, b, c, d);

// Connect the outputs to the output wire
or (out, w1, w2, w3, w4, w5, w6, w7, w8);

endmodule
