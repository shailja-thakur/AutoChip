module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

	wire ab_00;
	wire ab_01;
	wire ab_10;
	wire ab_11;

	assign ab_00 = ~a & ~b;
	assign ab_01 = ~a & b;
	assign ab_10 = a & ~b;
	assign ab_11 = a & b;

	assign mux_in[0] = ab_00 & c & d;
	assign mux_in[1] = ab_01 & c & ~d;
	assign mux_in[2] = ab_10 & ~c & b;
	assign mux_in[3] = ab_11 & (~c | d);

endmodule
