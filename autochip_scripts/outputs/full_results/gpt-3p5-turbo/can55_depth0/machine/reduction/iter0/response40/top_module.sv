module top_module (
	input [7:0] in,
	output parity
);

  // Parity bit calculation
  assign parity = ^in;
  
endmodule
