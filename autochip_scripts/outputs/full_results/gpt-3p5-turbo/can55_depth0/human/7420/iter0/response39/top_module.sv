module top_module(
	input [7:0] p1,
	output p1y,
	input [7:0] p2,
	output p2y
);

wire nand1;
nand n1(nand1, p1[0], p1[1], p1[2], p1[3]);
wire nand2;
nand n2(nand2, p1[4], p1[5], p1[6], p1[7]);

nand n3(p1y, nand1, nand2);

wire nand3;
nand n4(nand3, p2[0], p2[1], p2[2], p2[3]);
wire nand4;
nand n5(nand4, p2[4], p2[5], p2[6], p2[7]);

nand n6(p2y, nand3, nand4);

endmodule
