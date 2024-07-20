module top_module (
	input [7:0] in,
	output parity
);

  // Parity Check logic
  assign parity = ^in;

endmodule
