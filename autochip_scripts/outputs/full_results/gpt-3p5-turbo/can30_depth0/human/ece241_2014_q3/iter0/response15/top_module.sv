module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

wire a, b;

// Implementing the selectors for the 4-to-1 mux
not gate1 (c, a);
not gate2 (d, b);

// Implementing the K-map using one 4-to-1 mux and as few 2-to-1 muxes as possible
mux4to1 mux (
	.a(a),
	.b(b),
	.c(d),
	.d(c),
	.sel([a, b]),
	.out(mux_in)
);

endmodule
module mux4to1 (
	input a,
	input b,
	input c,
	input d,
	input [1:0] sel,
	output reg [3:0] out
);
	always @ (*)
	case (sel)
		2'b00: out = a;
		2'b01: out = b;
		2'b10: out = c;
		2'b11: out = d;
	endcase
endmodule
module not (
	input a,
	output out
);
	assign out = ~a;
endmodule
