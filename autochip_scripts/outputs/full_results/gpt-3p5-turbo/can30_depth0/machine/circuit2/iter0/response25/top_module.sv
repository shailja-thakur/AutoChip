module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
  
	// Intermediate wires
	wire x1, x2, x3;
	
	// XOR gates
	assign x1 = a ^ b;
	assign x2 = x1 ^ c;
	assign x3 = x2 ^ d;
	
	// Inverter
	assign q = ~x3;

endmodule
