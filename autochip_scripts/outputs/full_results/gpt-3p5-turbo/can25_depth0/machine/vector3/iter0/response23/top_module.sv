module top_module (
	input [4:0] a,
	input [4:0] b,
	input [4:0] c,
	input [4:0] d,
	input [4:0] e,
	input [4:0] f,
	output [7:0] w,
	output [7:0] x,
	output [7:0] y,
	output [7:0] z
);
	assign w = {a[4:0], 2'b11};
	assign x = {b[4:0], 2'b11};
	assign y = {c[4:0], 2'b11};
	assign z = {d[4:0], e[4:0], f[4:0], 2'b11};
endmodule
