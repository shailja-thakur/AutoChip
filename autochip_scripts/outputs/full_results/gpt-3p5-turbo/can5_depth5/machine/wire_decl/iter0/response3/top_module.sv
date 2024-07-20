module top_module (
  input a,
  input b,
  input c,
  input d,
  output out,
  output out_n );

  wire w1, w2;
  
  // Logical AND of inputs a and b
  assign w1 = a & b;
  
  // Logical AND of inputs c and d
  assign w2 = c & d;
  
  // Logical OR of wires w1 and w2
  assign out = w1 | w2;
  
  // Logical NOT of the output out
  assign out_n = ~out;
  
endmodule
