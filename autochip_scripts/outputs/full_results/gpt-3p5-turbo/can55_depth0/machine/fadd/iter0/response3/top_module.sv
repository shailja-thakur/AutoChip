module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);
  
  // Internal wire for the sum output
  wire [3:0] sum_internal;
  
  // Calculate the sum of a, b, and cin
  assign sum_internal = a + b + cin;
  
  // Calculate the carry-out bit (cout)
  assign cout = (sum_internal >= 2) ? 1'b1 : 1'b0;
  
  // Calculate the sum output modulo 2
  assign sum = sum_internal[1:0];
  
endmodule
