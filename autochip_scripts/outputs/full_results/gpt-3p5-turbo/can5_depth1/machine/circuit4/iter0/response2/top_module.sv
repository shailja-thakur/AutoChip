module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

  // Use an OR gate to compute the output q
  assign q = b | c;

endmodule
