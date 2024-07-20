module top_module (
	input a,
	input b,
	output sum,
	output cout
);
  // Code missing for the adder logic
  assign sum = a + b;
  assign cout = (a & b) | (a ^ b);
endmodule
