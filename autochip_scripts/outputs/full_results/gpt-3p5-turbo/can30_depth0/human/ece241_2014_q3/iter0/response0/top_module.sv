module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

// Implementing the Karnaugh map using multiplexers

// Intermediate signals
wire mux_c0d0;
wire mux_c0d1;
wire mux_c1d0;
wire mux_c1d1;
wire mux_ab_1;
wire mux_ab_0;

// 2-to-1 MUX for c=0 and d=0
mux2to1 mux_c0d0_inst (
	.a(c),
	.b(d),
	.sel(mux_ab_0),
	.out(mux_c0d0)
);

// 2-to-1 MUX for c=0 and d=1
mux2to1 mux_c0d1_inst (
	.a(c),
	.b(~d),
	.sel(mux_ab_0),
	.out(mux_c0d1)
);

// 2-to-1 MUX for c=1 and d=0
mux2to1 mux_c1d0_inst (
	.a(~c),
	.b(d),
	.sel(mux_ab_0),
	.out(mux_c1d0)
);

// 2-to-1 MUX for c=1 and d=1
mux2to1 mux_c1d1_inst (
	.a(~c),
	.b(~d),
	.sel(mux_ab_0),
	.out(mux_c1d1)
);

// 4-to-1 MUX with inputs connected to intermediate signals mux_c0d0, mux_c0d1, mux_c1d0, mux_c1d1 
mux4to1 mux_inst (
	.a(mux_c0d0),
	.b(mux_c0d1),
	.c(mux_c1d0),
	.d(mux_c1d1),
	.sel(mux_ab_1),
	.out(mux_in[3:0])
);

endmodule
