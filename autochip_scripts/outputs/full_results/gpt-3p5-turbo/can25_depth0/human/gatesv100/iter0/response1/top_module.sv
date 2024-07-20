module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

  wire [98:0] shifted_in;  // Wire to store the left-shifted input vector
  
  // Perform left shift on the input vector to get the shifted_in vector
  assign shifted_in[98:0] = in[99:1];
  assign shifted_in[99] = in[0];
  
  // Logic for out_both
  assign out_both = in[98:0] & shifted_in[98:0];
  
  // Logic for out_any
  assign out_any = in[99:1] | shifted_in[99:1];
  
  // Logic for out_different
  assign out_different = in[99:0] ^ shifted_in[99:0];
  
endmodule
