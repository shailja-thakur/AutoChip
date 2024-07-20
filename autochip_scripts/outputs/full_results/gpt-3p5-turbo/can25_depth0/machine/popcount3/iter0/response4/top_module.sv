module top_module (
	input [2:0] in,
	output [1:0] out
);
  // Adding the three input bits together
  assign out[1:0] = {in[2],in[1]} + in[0];
  
endmodule
