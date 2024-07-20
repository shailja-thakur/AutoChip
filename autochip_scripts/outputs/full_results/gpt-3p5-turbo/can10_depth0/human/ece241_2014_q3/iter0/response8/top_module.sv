module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

wire [3:0] and_outputs;

and u1 (and_outputs[0], ~c, d);
and u2 (and_outputs[1], c, ~d);
and u3 (and_outputs[2], ~c, ~d);
and u4 (and_outputs[3], c, d);

wire [1:0] ab;
and a0 (ab[0], ~a, ~b);
and a1 (ab[1], ~a, b);
and a2 (ab[2], a, ~b);
and a3 (ab[3], a, b);

wire [3:0] mux_out;
mux4x1 m1 (mux_out, ab, and_outputs);

assign mux_in = mux_out;

endmodule
module mux4x1 (
	input [1:0] ab,
	input [3:0] data,
	output out
);

assign out = (ab[1] & ab[0]) ? data[3] :
             (ab[1] & ~ab[0]) ? data[2] :
             (~ab[1] & ab[0]) ? data[1] :
             data[0];

endmodule
module and (
	input a,
	input b,
	output out
);

assign out = a & b;

endmodule
