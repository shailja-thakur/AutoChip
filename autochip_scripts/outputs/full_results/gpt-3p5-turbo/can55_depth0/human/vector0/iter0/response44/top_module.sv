module top_module(
	input [2:0] vec, 
	output [2:0] outv,
	output o2,
	output o1,
	output o0
);
  // assign the output vector to be the same as the input vector
  assign outv = vec;

  // assign each individual output to a specific bit of the input vector
  assign o2 = vec[2];
  assign o1 = vec[1];
  assign o0 = vec[0];
endmodule
