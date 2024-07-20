module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

wire w1, w2, w3, w4, w5;

nand w1_nand (a, b, w1);
nand w2_nand (c, d, w2);
nand w3_nand (a, c, w3);
nand w4_nand (b, d, w4);
nand w5_nand (w1, w2, w5);

or out_or (w3, w4, w5, out);

endmodule
