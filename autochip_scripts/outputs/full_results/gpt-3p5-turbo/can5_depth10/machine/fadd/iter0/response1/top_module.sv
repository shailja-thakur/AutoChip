module top_module (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);

  // Internal wire to hold the intermediate sum
  wire [1:0] sum_internal;
  
  // Assign statement to calculate the sum with carry in
  assign sum_internal = a + b + cin; // sum = a+b+cin
  
  // Assign statement to calculate the carry out
  assign cout = (sum_internal >= 2) ? 1'b1 : 1'b0; // cout = sum_internal >= 2 ? 1 : 0
  
  // Assign statement to calculate the final sum
  assign sum = sum_internal[0]; // sum = sum_internal[0]

endmodule
