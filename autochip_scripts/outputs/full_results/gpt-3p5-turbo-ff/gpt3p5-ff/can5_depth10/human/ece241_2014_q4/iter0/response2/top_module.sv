module top_module (
	input clk,
	input x,
	output z
);

reg d1, d2, d3;
wire q1, q2, q3;

xor gate1(q1, d1, x);
and gate2(q2, d2, x);
or gate3(q3, d3, x);

dff dff1(q1, clk, d1);
dff dff2(q2, clk, d2);
dff dff3(q3, clk, d3);

xnor gate4(z, q1, q2, q3);

endmodule
