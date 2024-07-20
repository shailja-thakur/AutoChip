module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);
  
  // Logic to calculate sum
  assign sum = a ^ b ^ cin;
  
  // Logic to calculate carry-out
  assign cout = (a & b) | (a & cin) | (b & cin);
  
endmodule
