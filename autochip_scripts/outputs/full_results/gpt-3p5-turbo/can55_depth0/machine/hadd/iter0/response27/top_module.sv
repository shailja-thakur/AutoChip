module top_module (
  input a,
  input b,
  output sum,
  output cout
);
  
  // Internal signals
  wire carry_out;
  
  // Adder logic
  assign {carry_out, sum} = a + b;
  
  // Carry out assignment
  assign cout = carry_out;
  
endmodule
