module top_module (
	input c,
	input d,
	output [3:0] mux_in
);
	
	wire w1, w2, w3, w4, w5, w6, w7, w8;
	
	and u1(w1, c, d);
	and u2(w2, !c, d);
	and u3(w3, !c, !d);
	and u4(w4, c, !d);
	and u5(w5, c, !d);
	
	assign mux_in[0] = !a & !b & w1;
	assign mux_in[1] = !a & b & w2;
	assign mux_in[2] = a & b & w3;
	assign mux_in[3] = a & !b & w4;
	
	// 2-to-1 muxes for a
	assign w6 = b ? mux_in[1] : mux_in[0];
	assign w7 = b ? mux_in[3] : mux_in[2];
	
	// 2-to-1 mux for b
	assign mux_in = a ? w7 : w6;
	
endmodule
