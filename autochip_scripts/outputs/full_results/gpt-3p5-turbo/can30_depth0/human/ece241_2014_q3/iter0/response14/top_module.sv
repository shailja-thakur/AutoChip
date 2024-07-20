module top_module (
	input c,
	input d,
	output [3:0] mux_in
);
	
	// Declare internal signals
	reg m0, m1, m2, m3;
	
	// Implementing the Karnaugh map using multiplexers
	// c = 0, d = 0
	assign mux_in[0] = m0 & (~c) & (~d);
	// c = 0, d = 1
	assign mux_in[1] = m1 & (~c) & d;
	// c = 1, d = 1
	assign mux_in[2] = m2 & c & d;
	// c = 1, d = 0
	assign mux_in[3] = m3 & c & (~d);
	
	// 4-to-1 multiplexer
	assign m0 = (mux_in[0] & (~a) & (~b)) | (mux_in[1] & (~a) & b);
	assign m1 = (mux_in[2] & a & b) | (mux_in[3] & a & (~b));
	
endmodule
