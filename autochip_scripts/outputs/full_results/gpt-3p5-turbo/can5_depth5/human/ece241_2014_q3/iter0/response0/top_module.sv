module top_module (
	input c,
	input d,
	output [3:0] mux_in
);
  // Implementation of the K-map using multiplexers
  
  // Implementing the 4-to-1 multiplexer
  
  // Output connected to mux_in[0]
  assign mux_in[0] = (c & d) | (c & ~d) | (~c & d) | (~c & ~d);
  
  // Implementing the 2-to-1 multiplexers
  
  // Output connected to mux_in[1]
  assign mux_in[1] = (c & ~d) | (~c & ~d);
  
  // Output connected to mux_in[2]
  assign mux_in[2] = (c & d) | (~c & d) | (~c & ~d);
  
  // Output connected to mux_in[3]
  assign mux_in[3] = (c & d) | (c & ~d) | (c & ~d) | (~c & d) | (~c & ~d);
  
endmodule
