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
	
	assign w = {a[4], b[4], c[4], d[4], e[4], f[4], 2'b11};
	assign x = {a[3:0], b[3:0], c[3:0], d[3:0], e[3:0], f[3:0], 2'b11};
	assign y = {a[2:0], b[2:0], c[2:0], d[2:0], e[2:0], f[2:0], 2'b11};
	assign z = {a[1:0], b[1:0], c[1:0], d[1:0], e[1:0], f[1:0], 2'b11};
	
endmodule
