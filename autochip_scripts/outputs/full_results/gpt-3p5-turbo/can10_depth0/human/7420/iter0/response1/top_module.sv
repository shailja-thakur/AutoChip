module top_module(
	input [7:0] p1,
	output reg p1y,
	input [7:0] p2,
	output reg p2y
);

reg [7:0] nand1;
reg [7:0] nand2;

assign p1y = ~(p1[0] & p1[1] & p1[2] & p1[3]);
assign p2y = ~(p2[0] & p2[1] & p2[2] & p2[3]);

endmodule
