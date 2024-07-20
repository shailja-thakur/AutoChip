module top_module (
  input in1,
  input in2,
  output logic out
);

  // Internal wire to store the logical OR result of in1 and in2
  wire or_result;

  // Assign the logical OR of in1 and in2 to or_result
  assign or_result = in1 | in2;

  // Assign the logical negation of or_result to out
  assign out = ~or_result;

endmodule
