module top_module (
  input a, 
  input b, 
  output q
);
	
  // And gate for input a and b
  assign q = a & b;
  
endmodule
