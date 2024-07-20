module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);
	// Declaration of internal wires and reg variables
	wire c1;
	reg [31:0] temp;
	
	// Calculation of sum
	assign sum = (a + b + cin) & 1;
	
	// Calculation of carry-out bit
	assign c1 = (a + b + cin) >= 2;
	assign cout = c1;
	
endmodule
