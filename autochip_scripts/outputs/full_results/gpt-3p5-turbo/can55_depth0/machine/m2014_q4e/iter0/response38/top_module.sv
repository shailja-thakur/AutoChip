module top_module (
  input in1,
  input in2,
  output logic out
);

  // Complete the module using the truth table for the desired functionality
  always_comb begin
    if (in1 == 0 && in2 == 0)
      out = 1;
    else
      out = 0;
  end
  
endmodule
