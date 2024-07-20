module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

	assign mux_in[0] = (~c & d) | (c & d);   // 00 | 01 | 10 | 11 = 1
	assign mux_in[1] =  0;                   // 00 = 0
	assign mux_in[2] = (c & d);              // 11 = 1, otherwise 0
	assign mux_in[3] = (~c & ~d) | (c & ~d); // 10 = 1
  
endmodule
