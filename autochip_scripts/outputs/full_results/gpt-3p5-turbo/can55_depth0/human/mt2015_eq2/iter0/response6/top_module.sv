module top_module(
	input [1:0] A,
	input [1:0] B,
	output wire z);  // Add "wire"
  
  // Verilog code for comparing A and B
  assign z = (A == B) ? 1'b1 : 1'b0;
  
endmodule
