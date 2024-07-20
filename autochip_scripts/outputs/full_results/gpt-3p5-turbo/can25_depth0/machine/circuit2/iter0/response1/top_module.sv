module top_module (
  input a,
  input b,
  input c,
  input d,
  output q
);

  wire x;
  
  xor x1 (
    .a(a),
    .b(b),
    .o(x)
  );
  
  xor x2 (
    .a(x),
    .b(c),
    .o(q)
  );

  xor x3 (
    .a(q),
    .b(d),
    .o(q)
  );

endmodule
