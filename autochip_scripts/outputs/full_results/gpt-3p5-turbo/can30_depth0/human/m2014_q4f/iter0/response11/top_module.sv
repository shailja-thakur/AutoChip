module top_module (
  input in1,
  input in2,
  output logic out
);
  // Module declarations and wiring
  wire in2_inverted;
  assign in2_inverted = ~in2;

  // AND gate
  and gate1 (
    .in1(in1),
    .in2(in2_inverted),
    .out(out)
  );
endmodule
