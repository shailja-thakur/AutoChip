module top_module (
  input a,
  input b,
  input c,
  input d,
  output q
);

  // combinational logic
  assign q = (~c & (d | b)) | (a & ~b & ~c & ~d);

endmodule
