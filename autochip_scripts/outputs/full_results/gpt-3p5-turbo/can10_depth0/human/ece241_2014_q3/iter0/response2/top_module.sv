module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

wire [3:0] mux_out;

// Implementing the circuit using one 4-to-1 multiplexer and two 2-to-1 multiplexers

// 2-to-1 multiplexer for mux_in[0] and mux_in[1] inputs
wire mux_in_0_1;
wire mux_sel_0;
wire mux_sel_1;

// 2-to-1 multiplexer for mux_in[2] and mux_in[3] inputs
wire mux_in_2_3;
wire mux_sel_2;
wire mux_sel_3;

// Mux_sel_0 and mux_sel_1 calculation
assign mux_sel_0 = ~c & d;
assign mux_sel_1 = ~d;

// Mux_sel_2 and mux_sel_3 calculation
assign mux_sel_2 = ~c | d;
assign mux_sel_3 = c;

// Mux_in_0_1 calculation
assign mux_in_0_1 = mux_sel_0 ? 0 : (mux_sel_1 ? 1 : 10);

// Mux_in_2_3 calculation
assign mux_in_2_3 = mux_sel_2 ? 11 : (mux_sel_3 ? 100 : 1);

// 4-to-1 multiplexer
mux4to1 mux (
	.a(c),
	.b(d),
	.s({mux_sel_0, mux_sel_1, mux_sel_2, mux_sel_3}),
	.y(mux_out)
);

// wire mux_in connections
assign mux_in[0] = mux_in_0_1;
assign mux_in[1] = mux_in_0_1;
assign mux_in[2] = mux_in_2_3;
assign mux_in[3] = mux_in_2_3;

endmodule
module mux4to1 (
	input a,
	input b,
	input [3:0] s,
	output y
);

wire [1:0] m0, m1, m2, m3;

assign m0 = a & b & ~s[1] & ~s[0];
assign m1 = a & ~b & ~s[1] & s[0];
assign m2 = a & ~b & s[1] & s[0];
assign m3 = a & b & s[1] & ~s[0];

assign y = m0 | m1 | m2 | m3;

endmodule
