module top_module (
	input a, 
	input b, 
	output q
);

  assign q = (a & ~b); // The circuit implements the logical AND operation between a and the complement of b

endmodule
