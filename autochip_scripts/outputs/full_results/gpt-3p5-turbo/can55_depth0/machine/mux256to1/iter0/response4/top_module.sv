module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);
  wire [7:0] select_index;
  
  assign select_index = sel;
  assign out = in[select_index];
  
endmodule
