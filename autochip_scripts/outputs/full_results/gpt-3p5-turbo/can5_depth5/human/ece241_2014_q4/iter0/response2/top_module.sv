module top_module (
	input clk,
	input x,
	output z
);

reg d1;
reg d2;
reg d3;
wire q1;
wire q2;
wire q3;

assign z = ~(q1 ^ q2 ^ q3);

always @(posedge clk)
begin
	d1 <= x ^ q1;
	d2 <= ~x & q2;
	d3 <= ~x | q3;
end

d_ff dff1 (
	.clk(clk),
	.d(d1),
	.q(q1)
);

d_ff dff2 (
	.clk(clk),
	.d(d2),
	.q(q2)
);

d_ff dff3 (
	.clk(clk),
	.d(d3),
	.q(q3)
);

endmodule
module d_ff (
	input clk,
	input d,
	output q
);

reg q;

always @(posedge clk)
begin
	q <= d;
end

assign q = q;

endmodule
