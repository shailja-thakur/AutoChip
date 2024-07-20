module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

wire ab0, ab1, ab2, ab3;

assign ab0 = 0;
assign ab1 = 0;
assign ab2 = 1;
assign ab3 = 1;

assign mux_in[0] = c & ~d;
assign mux_in[1] = ~c & ~d;
assign mux_in[2] = ~c & d;
assign mux_in[3] = c & d;

endmodule
