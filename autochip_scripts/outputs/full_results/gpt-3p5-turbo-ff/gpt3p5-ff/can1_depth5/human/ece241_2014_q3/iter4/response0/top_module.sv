module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

wire ab_00, ab_01, ab_11, ab_10;

assign ab_00 = d & ~c;
assign ab_01 = ~d & ~c;
assign ab_11 = ~d & c;
assign ab_10 = d & c;

assign mux_in[0] = ab_00;
assign mux_in[1] = ab_01;
assign mux_in[2] = ab_11;
assign mux_in[3] = ab_10;

endmodule
