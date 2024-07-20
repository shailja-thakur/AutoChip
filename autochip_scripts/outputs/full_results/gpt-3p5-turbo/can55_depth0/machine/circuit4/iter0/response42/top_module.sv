module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
  
  // Required logic gate
  assign q = b | c;

endmodule
