module top_module(
	input [7:0] p1,
	output p1y,
	input [7:0] p2,
	output p2y
);
	// 4-input NAND gate implementation
	wire [3:0] nand1_out;
	assign nand1_out[0] = ~(&p1[3:0]);
	assign nand1_out[1] = ~(&p2[3:0]);
	
	wire [3:0] nand2_out;
	assign nand2_out[0] = ~(&p1[7:4]);
	assign nand2_out[1] = ~(&p2[7:4]);
	
	// Outputs
	assign p1y = ~(|nand1_out);
	assign p2y = ~(|nand2_out);
	
endmodule
