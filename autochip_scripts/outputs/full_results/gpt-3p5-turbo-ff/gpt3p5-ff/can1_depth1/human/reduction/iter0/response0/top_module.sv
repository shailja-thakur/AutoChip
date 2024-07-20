module top_module (
	input [7:0] in,
	output parity
);

  // Internal wires declaration
  wire [7:0] in_xor;
  
  // Compute XOR of all input bits
  assign in_xor = ^in;
  
  // Compute the parity bit
  assign parity = in_xor;
  
endmodule
