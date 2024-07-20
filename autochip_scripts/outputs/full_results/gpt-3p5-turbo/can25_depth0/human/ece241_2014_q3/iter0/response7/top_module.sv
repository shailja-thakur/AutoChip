module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

wire [3:0] temp;
wire [3:0] mux_out;

and G1 (temp[0], ~c, ~d);
and G2 (temp[1], ~c, ~d);
and G3 (temp[2], c, ~d);
and G4 (temp[3], ~d);

and G5 (mux_out[0], ~a, ~b);
and G6 (mux_out[1], ~a, b);
and G7 (mux_out[2], a, b);
and G8 (mux_out[3], a, ~b);

mux_4to1 MUX (
	.out(mux_in),
	.in0(temp[0]),
	.in1(temp[1]), 
	.in2(temp[2]),
	.in3(temp[3]),
	.a(a),
	.b(b)
);

endmodule
