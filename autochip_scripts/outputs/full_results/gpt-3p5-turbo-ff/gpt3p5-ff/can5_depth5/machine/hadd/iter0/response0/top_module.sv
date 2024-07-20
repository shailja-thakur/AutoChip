module top_module (
  input a,
  input b,
  output sum,
  output cout
);
  
  // Declare internal wire for carry out
  wire carry;
  
  // Adder logic
  assign sum = a + b;
  assign cout = carry;
  
endmodule
