module top_module(
	input x,
	input y,
	output z);
	
	// XOR gate
	wire xor;
	assign xor = x ^ y;
	
	// AND gate
	wire and;
	assign and = xor & x;
	
	// Output
	assign z = and;
	
endmodule
