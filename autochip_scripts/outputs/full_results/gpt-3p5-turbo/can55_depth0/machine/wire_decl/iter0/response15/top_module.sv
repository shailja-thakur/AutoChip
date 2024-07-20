module top_module (
  input a,
  input b,
  input c,
  input d,
  output out,
  output out_n );  

  wire w1, w2;

  assign w1 = a & b;  // assign the value of the logical AND of inputs a and b to wire w1
  assign w2 = c & d;  // assign the value of the logical AND of inputs c and d to wire w2

  assign out = w1 | w2;  // assign the value of the logical OR of wires w1 and w2 to output out
  assign out_n = ~out;   // assign the logical NOT of output out to output out_n

endmodule
