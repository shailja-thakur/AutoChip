module top_module (
	input a,
	input b,
	output sum,
	output cout
);
  
	/* Adder logic */
	assign sum = a + b;
	assign cout = (a & b) | (a ^ b);

endmodule
