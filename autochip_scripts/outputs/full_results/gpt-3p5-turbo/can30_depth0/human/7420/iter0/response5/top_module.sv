module top_module(
	input [7:0] p1,
	input [7:0] p2,
	output [1:0] y
);

	assign y[0] = ~(p1[0] & p1[1] & p1[2] & p1[3]);
	assign y[1] = ~(p2[0] & p2[1] & p2[2] & p2[3]);

endmodule
