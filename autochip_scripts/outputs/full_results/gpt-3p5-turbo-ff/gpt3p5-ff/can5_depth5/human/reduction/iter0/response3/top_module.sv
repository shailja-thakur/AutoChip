module top_module (
	input [7:0] in,
	output parity
);
  
  // Wire declaration to store the final parity bit
  wire parity_wire;
  
  // XOR gate to compute the parity
  assign parity_wire = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];
  
  // Assign the parity bit to the output port
  assign parity = parity_wire;
  
endmodule
