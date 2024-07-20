module top_module (
	input [5:0] y,
	input w,
	output reg Y1,
	output reg Y3
);

  // Assign Y1 as the logical AND of the first bit of the input vector y and the single bit input w
  assign Y1 = y[0] & w;
  
  // Assign Y3 as the logical AND of the logical OR of the second, third, fifth and sixth bits of the input vector y
  // and the logical NOT of the single bit input w
  assign Y3 = (y[1] | y[2] | y[4] | y[5]) & (~w);
  
endmodule
