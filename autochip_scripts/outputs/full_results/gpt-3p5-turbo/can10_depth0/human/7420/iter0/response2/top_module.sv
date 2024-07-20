module top_module(
	  input [7:0] p1,
	  output reg p1y,
	  input [7:0] p2,
	  output reg p2y
	);

wire [3:0] NAND1; 
wire [3:0] NAND2;
wire [1:0] NAND3;

nand4 #(4) U1(NAND1[0], p1[3], p1[2], p1[1], p1[0]);
nand4 #(4) U2(NAND2[0], p1[7], p1[6], p1[5], p1[4]);
nand4 #(4) U3(NAND1[1], p2[3], p2[2], p2[1], p2[0]);
nand4 #(4) U4(NAND2[1], p2[7], p2[6], p2[5], p2[4]);

nand2 #(4) U5(NAND3[0], NAND1[0], NAND1[1]);
nand2 #(4) U6(NAND3[1], NAND2[0], NAND2[1]);

nand4 #(2) U7(p1y, NAND3[0], NAND3[1], 1'b1, 1'b1);
nand4 #(2) U8(p2y, NAND3[0], NAND3[1], 1'b1, 1'b1);

endmodule
