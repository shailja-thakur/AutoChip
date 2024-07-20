module top_module (
	input clk,
	input x,
	output z
);

reg d1,d2,d3;
wire q1_n,q2_n,q3_n;

assign q1_n = ~d1;
assign q2_n = ~d2;
assign q3_n = ~d3;

xor x1gate (x, d1, z1);
and x2gate (x, q2_n, z2);
or x3gate (x, q3_n, z3);

dflipflop dff1 (
	.clk(clk),
	.d(z1),
	.q(d1)
);

dflipflop dff2 (
	.clk(clk),
	.d(z2),
	.q(d2)
);

dflipflop dff3 (
	.clk(clk),
	.d(z3),
	.q(d3)
);

xnor xnor_gate (
	.z(z),
	.a(d1),
	.b(d2),
	.c(d3)
);

endmodule
module dflipflop (
	input clk,
	input d,
	output q
);

reg q;

always @(posedge clk) begin
	q <= d;
end

endmodule
module xor (
	input a,
	input b,
	output z
);

assign z = a ^ b;

endmodule
module and (
	input a,
	input b,
	output z
);

assign z = a & b;

endmodule
module or (
	input a,
	input b,
	output z
);

assign z = a | b;

endmodule
module xnor (
	input a,
	input b,
	input c,
	output z
);

assign z = ~(a ^ b ^ c);

endmodule
