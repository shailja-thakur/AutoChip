module top_module(
  input a, 
  input b,
  input c,
  output out
);
  
  // Construct the truth table based on the Karnaugh map
  // where the inputs are a, b, c and the output is out
  assign out = (a & ~b & ~c) | (a & b) | (~a & b & c) | (a & b & c);
  
endmodule
