module top_module(
	input p1a, 
	input p1b, 
	input p1c, 
	input p1d, 
	output p1y, 
	input p2a, 
	input p2b, 
	input p2c, 
	input p2d, 
	output p2y
);

wire [3:0] nand1_in;
wire [3:0] nand2_in;

assign nand1_in = {p1a, p1b, p1c, p1d};
assign nand2_in = {p2a, p2b, p2c, p2d};

nand #4 nand1(.a(nand1_in), .y(p1y));
nand #4 nand2(.a(nand2_in), .y(p2y));

endmodule
