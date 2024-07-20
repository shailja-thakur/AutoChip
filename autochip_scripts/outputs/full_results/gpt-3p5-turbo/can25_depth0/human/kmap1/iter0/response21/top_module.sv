module top_module(
  input a,
  input b,
  input c,
  output out
);

  wire d1, d2, d3, d4;
  
  and gate1(d1, a, b);
  and gate2(d2, b, c);
  and gate3(d3, a, !c);
  or gate4(out, d1, d2, d3);

endmodule
module and(
  output q,
  input a,
  input b
);
  assign q = a & b;
endmodule
module or(
  output q,
  input a,
  input b,
  input c
);
  assign q = a | b | c;
endmodule
