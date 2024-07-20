module top_module (
  input a,
  input b,
  input c,
  input d,
  output out
);

  // Define intermediate signals
  wire p1;
  wire p2;
  wire p3;

  // Implement the Karnaugh map logic
  assign p1 = a & b & c & ~d;
  assign p2 = a & b & c & d;
  assign p3 = a & b & ~c;

  // Output assignment
  assign out = p1 | p2 | p3;

endmodule
