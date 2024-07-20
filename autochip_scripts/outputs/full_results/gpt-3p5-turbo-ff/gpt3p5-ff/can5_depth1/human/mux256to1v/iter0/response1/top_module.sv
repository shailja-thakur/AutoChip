module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

  wire [255:0] out_sel;
  
  assign out_sel[0] = in[4*sel+3:4*sel];
  
  // Add assignments for remaining out_sel bits
  
  assign out = out_sel;
  
endmodule
