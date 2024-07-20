module top_module (
  input a,
  input b,
  input c,
  input d,
  output q
);
  
  wire q_temp;
  
  assign q_temp = (a & b) | (c & ~d);
  assign q = q_temp;
  
endmodule
