module top_module (
	input a,
	input b,
	input sel,
	output out
);

  wire mux_out; // intermediate wire to hold the output of the multiplexer

  // 1-bit 2-to-1 multiplexer implementation
  assign mux_out = sel ? b : a;

  // Assigning the output of the multiplexer to the 'out' output port
  assign out = mux_out;

endmodule
