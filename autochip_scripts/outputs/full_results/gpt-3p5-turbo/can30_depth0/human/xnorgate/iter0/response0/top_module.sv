module top_module(
  input a,
  input b,
  output out
);
  wire a_not, b_not;
  wire a_and_b;
  
  // Gate level implementation
  assign a_not = ~a;
  assign b_not = ~b;
  assign a_and_b = a_not & b_not;
  assign out = ~a_and_b;
  
endmodule
