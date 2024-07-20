module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

// Declare internal signals
wire [1:0] ab;
wire w0, w1, w2, w3;

// Multiplexer MUX0 with ab = 00
mux2to1 mux0 (
	.sel(0),
	.a({c, d}),
	.b(1'b0),
	.out(w0)
);

// Multiplexer MUX1 with ab = 01
mux2to1 mux1 (
	.sel(1),
	.a({c, d}),
	.b(1'b0),
	.out(w1)
);

// Multiplexer MUX2 with ab = 11
mux2to1 mux2 (
	.sel(3),
	.a({c, d}),
	.b(1'b1),
	.out(w2)
);

// Multiplexer MUX3 with ab = 10
mux2to1 mux3 (
	.sel(2),
	.a({c, d}),
	.b(1'b0),
	.out(w3)
);

// 4-to-1 Multiplexer
mux4to1 mux4 (
	.sel(ab),
	.in({w0, w1, w2, w3}),
	.out(mux_in)
);

// Assign ab based on inputs c and d
assign ab = {c, d};

endmodule
module mux2to1 (
	input sel,
	input a,
	input b,
	output reg out
);
	always @ (*)
		begin
			if (sel == 1'b0)
				out = a;
			else
				out = b;
		end
endmodule
module mux4to1 (
	input [1:0] sel,
	input [3:0] in,
	output reg [3:0] out
);
	always @ (*)
		begin
			case (sel)
				2'b00: out = in[0];
				2'b01: out = in[1];
				2'b10: out = in[2];
				2'b11: out = in[3];
			endcase
		end
endmodule
