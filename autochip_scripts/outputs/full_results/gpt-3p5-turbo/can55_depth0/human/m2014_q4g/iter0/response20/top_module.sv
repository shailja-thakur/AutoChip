module xnor_xnor_xor(
  input in1,
  input in2,
  input in3,
  output out
);

  wire xnor_out;
  assign xnor_out = ~(in1 ^ in2);

  xor xor_gate(
    .a(xnor_out),
    .b(in3),
    .out(out)
  );

endmodule
module top_module (
  input in1,
  input in2,
  input in3,
  output out
);
  
  xnor_xnor_xor u1 (
    .in1(in1),
    .in2(in2),
    .in3(in3),
    .out(out)
  );
  
endmodule
