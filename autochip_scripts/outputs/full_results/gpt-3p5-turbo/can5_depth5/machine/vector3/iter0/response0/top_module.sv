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
	
	assign w = {a, b[3:0]};
	assign x = {b[4], c[3:0]};
	assign y = {c[4:1], d[0]};
	assign z = {d[4:2], e[1:0], f};

endmodule
