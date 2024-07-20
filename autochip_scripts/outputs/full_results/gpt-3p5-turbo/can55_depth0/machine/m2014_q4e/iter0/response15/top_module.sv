module top_module (
  input in1,
  input in2,
  output logic out
);

  // Create a wire to represent the logical OR of in1 and in2
  wire logical_or;
  
  // Create a wire to represent the logical negation of logical_or
  wire logical_negation;
  
  // Perform the logical OR operation
  assign logical_or = in1 | in2;
  
  // Perform the logical negation operation
  assign logical_negation = ~logical_or;
  
  // Assign the result of the logical negation to the out signal
  assign out = logical_negation;
  
endmodule
