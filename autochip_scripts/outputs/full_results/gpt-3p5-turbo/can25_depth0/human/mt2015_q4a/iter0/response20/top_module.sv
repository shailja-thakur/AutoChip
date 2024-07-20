module top_module(
    input x,
    input y,
    output z
);

  // wire for storing the result of (x^y)
  wire xor_result;
  
  // simple XOR operation to calculate (x^y)
  assign xor_result = x ^ y;

  // calculate the final result by ANDing (x^y) and x
  assign z = xor_result & x;

endmodule
