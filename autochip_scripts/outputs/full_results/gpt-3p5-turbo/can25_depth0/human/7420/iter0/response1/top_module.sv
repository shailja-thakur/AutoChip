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
    // Declare intermediate signals
    wire nand1_out, nand2_out;
    
    // Instantiate the 4-input NAND gates
    nand4 nand1(.a(p1a), .b(p1b), .c(p1c), .d(p1d), .y(nand1_out));
    nand4 nand2(.a(p2a), .b(p2b), .c(p2c), .d(p2d), .y(nand2_out));
    
    // Assign outputs
    assign p1y = nand1_out;
    assign p2y = nand2_out;

endmodule
module nand4(
    input a, 
    input b, 
    input c, 
    input d, 
    output y
);
    // Declare intermediate signals
    wire nand1_out, nand2_out, nand3_out;
    
    // Instantiate the 2-input NAND gates
    nand2 nand1(.a(a), .b(b), .y(nand1_out));
    nand2 nand2(.a(c), .b(d), .y(nand2_out));
    nand2 nand3(.a(nand1_out), .b(nand2_out), .y(nand3_out));
    
    // Instantiate the 2-input NAND gate cascading output
    nand2 nand4(.a(nand3_out), .b(nand3_out), .y(y));

endmodule
module nand2(
    input a, 
    input b, 
    output y
);
    // Behavioral model of a NAND gate
    assign y = ~(a & b);

endmodule
