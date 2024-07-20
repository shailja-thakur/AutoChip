module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);
  
  // Intermediate signals
  wire [98:0] in_left_shifted;
  wire [99:0] in_right_shifted;
  
  // Generate left shifted input
  assign in_left_shifted = {in[98:0], 1'b0};
  
  // Generate right shifted input
  assign in_right_shifted = {1'b0, in};
  
  // Compute out_both
  assign out_both = in & in_left_shifted;
  
  // Compute out_any
  assign out_any = in | in_right_shifted;
  
  // Compute out_different
  assign out_different = in ^ in_left_shifted;
  
endmodule
