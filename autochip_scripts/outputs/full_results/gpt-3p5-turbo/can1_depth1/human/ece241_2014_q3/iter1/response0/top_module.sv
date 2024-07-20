module top_module (
	input c,
	input d,
	output [3:0] mux_in
);
	// Implementing Karnaugh map using multiplexers
	
	// Input combinations and their corresponding outputs
	assign mux_in[0] = (~c & ~d) | (c & ~d);
	assign mux_in[1] = c & ~d;
	assign mux_in[2] = (~c & d) | (c & d);
	assign mux_in[3] = c & d;
	
endmodule
