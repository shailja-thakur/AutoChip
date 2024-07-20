module top_module(
	input [3:0] p1,
	output p1y,
	input [3:0] p2,
	output p2y
);

	assign p1y = ~(p1[0] & p1[1] & p1[2] & p1[3]);
	assign p2y = ~(p2[0] & p2[1] & p2[2] & p2[3]);

endmodule
