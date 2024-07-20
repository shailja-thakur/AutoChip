module top_module (
	input clk,
	input x,
	output z
);
	reg d1, d2, d3;
	wire q1, q2, q3;
	xor #(2) u1(q2, d1, q1);
	and #(2) u2(q3, d2, ~q2);
	or #(2) u3(q3, d3, ~q3);
	xnor #(3) u4(z, q1, ~q2, ~q3);
	d_flip_flop #(1) u5(clk, d1, x, q1);
	d_flip_flop #(1) u6(clk, d2, q1, q2);
	d_flip_flop #(1) u7(clk, d3, ~q1, q3);
endmodule
module d_flip_flop #(parameter WIDTH = 1) (
	input clk,
	input d,
	input reset,
	output reg [WIDTH-1:0] q
);
	always @(posedge clk or posedge reset)
		if (reset)
			q <= 0;
		else
			q <= d;
endmodule
module xor #(parameter WIDTH = 1) (
	output reg [WIDTH-1:0] z,
	input [WIDTH-1:0] a,
	input [WIDTH-1:0] b
);
	always @(a or b)
		z <= a ^ b;
endmodule
module and #(parameter WIDTH = 1) (
	output reg [WIDTH-1:0] z,
	input [WIDTH-1:0] a,
	input [WIDTH-1:0] b
);
	always @(a or b)
		z <= a & b;
endmodule
module or #(parameter WIDTH = 1) (
	output reg [WIDTH-1:0] z,
	input [WIDTH-1:0] a,
	input [WIDTH-1:0] b
);
	always @(a or b)
		z <= a | b;
endmodule
module xnor #(parameter WIDTH = 1) (
	output reg [WIDTH-1:0] z,
	input [WIDTH-1:0] a,
	input [WIDTH-1:0] b,
	input [WIDTH-1:0] c
);
	always @(a or b or c)
		z <= ~(a ^ b ^ c);
endmodule
