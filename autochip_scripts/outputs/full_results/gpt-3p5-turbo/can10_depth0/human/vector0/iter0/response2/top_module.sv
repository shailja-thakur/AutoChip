module top_module(
	input [2:0] vec, 
	output [2:0] outv,
	output o2,
	output o1,
	output o0
);
  // Assigning outputs to respective bits of input vector
  assign {o2, o1, o0} = vec;
  
  // Assigning input vector to output vector
  assign outv = vec;
  
endmodule
