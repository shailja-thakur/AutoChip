module top_module (
  input a,
  input b,
  input c,
  input d,
  output out,
  output out_n 
);

  wire and1_output, and2_output;

  and gate_and1 (
    .a(a),
    .b(b),
    .z(and1_output)
  );

  and gate_and2 (
    .a(c),
    .b(d),
    .z(and2_output)
  );

  or gate_or (
    .a(and1_output),
    .b(and2_output),
    .z(out)
  );

  not gate_not (
    .a(out),
    .z(out_n)
  );
    
endmodule
