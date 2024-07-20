module top_module(
	input a, 
	input b,
	output out
);
	
	// Implementation of XNOR gate using NAND and NOT gates
	wire nand1_gate, nand2_gate, nand3_gate;
	
	nand nand1(
		.a(a),
		.b(b),
		.out(nand1_gate)
	);
	
	not not1(
		.in(nand1_gate),
		.out(nand2_gate)
	);
	
	nand nand2(
		.a(a),
		.b(b),
		.out(nand3_gate)
	);
	
	nand nand4(
		.a(nand2_gate),
		.b(nand3_gate),
		.out(out)
	);
	
endmodule
