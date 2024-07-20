module top_module(
	input [7:0] p1,
	output p1y,
	input [7:0] p2,
	output p2y
);

	assign p1y = ~(&p1);
	assign p2y = ~(&p2);

endmodule
