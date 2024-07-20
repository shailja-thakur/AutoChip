module top_module(
	input [7:0] p1,
	output [1:0] p1y
);
	assign p1y[0] = ~(p1[0] & p1[1] & p1[2] & p1[3]);
	assign p1y[1] = ~(p1[4] & p1[5] & p1[6] & p1[7]);
endmodule
