module top_module (
  input a,
  input b,
  input c,
  input d,
  output out
);
  // output signal is calculated using logical OR operation
  assign out = (~b & ~c) | (~a & ~d) | (a & c & d) | (b & c & d);
endmodule
