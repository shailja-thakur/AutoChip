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
	
	// Declare internal signals
	wire nand1_out, nand2_out;

	// Instantiate NAND gates
	NAND4 nand1(.a(p1a), .b(p1b), .c(p1c), .d(p1d), .y(nand1_out));
	NAND4 nand2(.a(p2a), .b(p2b), .c(p2c), .d(p2d), .y(nand2_out));

	// Assign outputs
	assign p1y = nand1_out;
	assign p2y = nand2_out;

endmodule
module NAND4(
	input a, 
	input b, 
	input c, 
	input d, 
	output y
);
	
	// Internal signals
	wire nand1_out, nand2_out, nand3_out;

	// Instantiate NAND gates
	NAND2 nand1(.a(a), .b(b), .y(nand1_out));
	NAND2 nand2(.a(c), .b(d), .y(nand2_out));
	NAND2 nand3(.a(nand1_out), .b(nand2_out), .y(nand3_out));

	// Inverter for NAND3 output
	NOT1 inv(.a(nand3_out), .y(y));
	
endmodule
module NAND2(
	input a, 
	input b, 
	output y
);
	
	// Internal signal
	wire nand_out;
	
	// Instantiate NAND gate
	NAND3 nand(.a(a), .b(b), .c(1'b1), .y(nand_out));
	
	// Inverter for NAND output
	NOT1 inv(.a(nand_out), .y(y));
	
endmodule
module NAND3(
	input a, 
	input b, 
	input c, 
	output y
);
	
	// Internal signal
	wire nand1_out, nand2_out;
	
	// Instantiate NAND gates
	NAND2 nand1(.a(a), .b(b), .y(nand1_out));
	NAND2 nand2(.a(nand1_out), .b(c), .y(nand2_out));
	
	// Inverter for NAND2 output
	NOT1 inv(.a(nand2_out), .y(y));
	
endmodule
module NOT1(
	input a, 
	output y
);
	
	// Inverter logic
	assign y = ~a;
	
endmodule
