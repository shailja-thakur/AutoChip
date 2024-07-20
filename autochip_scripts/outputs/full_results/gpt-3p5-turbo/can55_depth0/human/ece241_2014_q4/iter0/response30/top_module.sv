module top_module (
	input clk,
	input x,
	output z
);

reg d1, d2, d3;
wire q1, q2, q3;

xor_gate xor1(x, q1, d1);
and_gate and1(x, ~q2, d2);
or_gate or1(x, ~q3, d3);

d_flip_flop_ff dff1(clk, d1, q1);
d_flip_flop_ff dff2(clk, d2, q2);
d_flip_flop_ff dff3(clk, d3, q3);

xnor_gate xnor1(q1, q2, q3, z);


endmodule
module xor_gate (
	input a,
	input b,
	output c
);

assign c = a ^ b;

endmodule
module and_gate (
	input a,
	input b,
	output c
);

assign c = a & b;

endmodule
module or_gate (
	input a,
	input b,
	output c
);

assign c = a | b;

endmodule
module d_flip_flop_ff (
	input clk,
	input d,
	output q
);

reg q;

always @(posedge clk) begin
	q <= d;
end

endmodule
module xnor_gate (
	input a,
	input b,
	input c,
	output d
);

wire w1, w2;

xor_gate xor2(a, b, w1);
xor_gate xor3(w1, c, w2);
xor_gate xor4(w2, 1'b1, d);

endmodule
