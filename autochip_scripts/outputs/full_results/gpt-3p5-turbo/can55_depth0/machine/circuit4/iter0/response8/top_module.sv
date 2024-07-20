module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

  // Assign output q the result of the logical OR operation between inputs b and c
  assign q = b || c;

endmodule
