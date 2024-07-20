module top_module (
  input in1,
  input in2,
  output logic out
);
  
  // Use the or operator to perform a logical OR operation on in1 and in2
  logic or_result;
  assign or_result = in1 | in2;

  // Use the not operator to perform a logical negation on or_result
  assign out = ~or_result;
  
endmodule
