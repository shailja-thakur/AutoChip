module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

// Implementing the K-map using multiplexers

// 2-to-1 multiplexer for mux_in[0]
assign mux_in[0] = (~c & ~d);

// 2-to-1 multiplexer for mux_in[1]
assign mux_in[1] = (c & ~d);

// 2-to-1 multiplexer for mux_in[2]
assign mux_in[2] = (c & d);

// 2-to-1 multiplexer for mux_in[3]
assign mux_in[3] = (~c & d);
 
endmodule
