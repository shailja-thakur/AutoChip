module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

wire w1, w2, w3, w4, w5, w6, w7, w8;

assign w1 = ~c & ~d;
assign w2 = c & ~d;
assign w3 = c & d;
assign w4 = ~c & d;
assign w5 = w2 | w3;
assign w6 = w1 | w4;
assign w7 = w1 | w3;
assign w8 = w2 | w4;

assign mux_in[0] = w6;
assign mux_in[1] = d;
assign mux_in[2] = ~d & ~c;
assign mux_in[3] = w5;

endmodule
