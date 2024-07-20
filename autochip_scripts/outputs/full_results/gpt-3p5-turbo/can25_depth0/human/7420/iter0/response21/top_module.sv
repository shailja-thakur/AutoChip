module top_module(
	input [7:0] p1,
	output p1y,
	input [7:0] p2,
	output p2y
);

wire [3:0] nand1_out;
wire [3:0] nand2_out;

nand nand1(.a({p1[3], p1[2], p1[1], p1[0]}), .y(nand1_out));
nand nand2(.a({p2[3], p2[2], p2[1], p2[0]}), .y(nand2_out));

assign p1y = ~(nand1_out[3] & nand1_out[2] & nand1_out[1] & nand1_out[0]);
assign p2y = ~(nand2_out[3] & nand2_out[2] & nand2_out[1] & nand2_out[0]);

endmodule
