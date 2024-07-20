module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
  
  // Use an OR gate to implement the desired logic
  // Output q is the result of a logical OR operation between b and c
  assign q = b | c;

endmodule
