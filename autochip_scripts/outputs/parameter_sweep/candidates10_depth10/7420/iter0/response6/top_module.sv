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
	
	// Internal wires
	wire nand1;
	wire nand2;
	
	// 4-input NAND gates
	nandgate4 u1(
		.p1a(p1a),
		.p1b(p1b),
		.p1c(p1c),
		.p1d(p1d),
		.y1(nand1)
	);
	
	nandgate4 u2(
		.p1a(p2a),
		.p1b(p2b),
		.p1c(p2c),
		.p1d(p2d),
		.y1(nand2)
	);
	
	// Output assignments
	assign p1y = nand1;
	assign p2y = nand2;
	
endmodule
module nandgate4(
	input p1a, 
	input p1b, 
	input p1c, 
	input p1d, 
	output y1
);
	
	// Intermediate nets
	wire inter1;
	wire inter2;
	wire inter3;
	
	// NAND gate sub-modules
	nandgate u1(
		.p1(p1a),
		.p2(p1b),
		.y(inter1)
	);
	
	nandgate u2(
		.p1(p1c),
		.p2(p1d),
		.y(inter2)
	);
	
	nandgate u3(
		.p1(inter1),
		.p2(inter2),
		.y(inter3)
	);
	
	// Inverter sub-module
	inverter u4(
		.p1(inter3),
		.y1(y1)
	);
	
endmodule
module nandgate(
	input p1,
	input p2,
	output y
);
	
	// Internal net
	wire inter;
	
	// AND gate sub-module
	andgate2 u1(
		.p1(p1),
		.p2(p2),
		.y(inter)
	);
	
	// Inverter sub-module
	inverter u2(
		.p1(inter),
		.y1(y)
	);
	
endmodule
module andgate2(
	input p1,
	input p2,
	output y
);
	
	assign y = p1 & p2;
	
endmodule
module inverter(
	input p1,
	output y1
);
	
	assign y1 = ~p1;
	
endmodule
