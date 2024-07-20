module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

  wire temp1;
  
  or gate1(temp1, b, c);
  
  assign q = temp1;

endmodule
