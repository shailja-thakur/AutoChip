module top_module(
	input [7:0] p1,
	output p1y,
	input [7:0] p2,
	output p2y
);

// define internal signals
wire [7:0] nand_in1;
wire [7:0] nand_in2;
wire [7:0] nand_out;

// connect inputs to internal signals
assign nand_in1 = {p1a, p1b, p1c, p1d};
assign nand_in2 = {p2a, p2b, p2c, p2d};

// instantiate NAND gates
nand_gate nand1(
	.n1(nand_in1),
	.n2(nand_in2),
	.y(nand_out)
);

// connect outputs to internal signals
assign p1y = nand_out[7];
assign p2y = nand_out[6];

endmodule
module nand_gate(
	input [7:0] n1,
	input [7:0] n2,
	output [7:0] y
);

// define internal signals
wire [7:0] nand_out;

// instantiate NAND gates
nand2_gate nand1(
	.a(n1[0]),
	.b(n2[0]),
	.y(nand_out[0])
);
nand2_gate nand2(
	.a(n1[1]),
	.b(n2[1]),
	.y(nand_out[1])
);
nand2_gate nand3(
	.a(n1[2]),
	.b(n2[2]),
	.y(nand_out[2])
);
nand2_gate nand4(
	.a(n1[3]),
	.b(n2[3]),
	.y(nand_out[3])
);
nand2_gate nand5(
	.a(n1[4]),
	.b(n2[4]),
	.y(nand_out[4])
);
nand2_gate nand6(
	.a(n1[5]),
	.b(n2[5]),
	.y(nand_out[5])
);
nand2_gate nand7(
	.a(n1[6]),
	.b(n2[6]),
	.y(nand_out[6])
);
nand2_gate nand8(
	.a(n1[7]),
	.b(n2[7]),
	.y(nand_out[7])
);

// assign output
assign y = nand_out;

endmodule
module nand2_gate(
	input a,
	input b,
	output y
);

assign y = ~(a & b);

endmodule
