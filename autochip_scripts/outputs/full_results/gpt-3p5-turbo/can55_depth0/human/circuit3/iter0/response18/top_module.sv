module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	
	// Define internal signals
	wire w1, w2, w3, w4, w5, w6, w7, w8, w9;
	
	// Define intermediate signals
	wire intermediate1;
	wire intermediate2;
	
	// Define the circuit
	assign w1 = a & b;
	assign w2 = a | b;
	assign w3 = c ^ d;
	assign w4 = w1 & w2;
	assign w5 = w1 & w3;
	assign w6 = w2 & w3;
	assign w7 = w1 & w2 & w3;
	assign w8 = w2 | w3;
	assign w9 = w1 | w3;
	assign intermediate1 = w4 | w5;
	assign intermediate2 = w6 | w7;
	
	assign q = intermediate1 & intermediate2;
	
endmodule
