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

	assign w = {a[4], a[3], a[2], a[1], a[0], 2'b11};
	assign x = {b[4], b[3], b[2], b[1], b[0], 2'b11};
	assign y = {c[4], c[3], c[2], c[1], c[0], 2'b11};
	assign z = {d[4], d[3], d[2], d[1], d[0], 2'b11};

endmodule
