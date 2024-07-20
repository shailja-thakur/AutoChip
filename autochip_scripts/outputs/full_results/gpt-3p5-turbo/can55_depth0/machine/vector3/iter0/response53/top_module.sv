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

	assign w = {a[4], b[4:0]};
	assign x = {a[3], b[3:0], c[4]};
	assign y = {a[2:0], b[2:0], c[3], d[4]};
	assign z = {a[1:0], b[1:0], c[2:0], d[3], e[4]};

endmodule
