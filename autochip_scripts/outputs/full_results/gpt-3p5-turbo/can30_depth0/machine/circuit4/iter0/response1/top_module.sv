module top_module (
  input a,
  input b,
  input c,
  input d,
  output q
);

  wire q_wire;
  
  or gate1(
    .a(b),
    .b(c),
    .q(q_wire)
  );
  
  assign q = q_wire;

endmodule
