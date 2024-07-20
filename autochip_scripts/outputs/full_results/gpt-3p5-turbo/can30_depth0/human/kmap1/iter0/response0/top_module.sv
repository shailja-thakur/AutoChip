module top_module(
    input a,
    input b,
    input c,
    output out
);
  
  wire d;
  
  // Implement the logic
  assign d = ((~a & ~b & ~c) | (a & ~b & ~c) | (a & b & ~c) | (a & b & c));
  assign out = d;
  
endmodule
