module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

  assign q = b | c; // perform logical OR operation on inputs b and c

endmodule
