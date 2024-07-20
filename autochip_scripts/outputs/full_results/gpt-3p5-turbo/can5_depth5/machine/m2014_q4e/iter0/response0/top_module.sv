module top_module (
  input in1,
  input in2,
  output logic out
);

  // Declaration of internal signals
  wire or_result;

  // Logical OR gate
  assign or_result = in1 | in2;

  // Logical NOT gate (inverter)
  assign out = ~or_result;

endmodule
