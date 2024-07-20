module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);
	// Define internal wires and registers
	wire w1, w2, w3;
	
	// Instantiate three 1-bit full adders
	full_adder fa1(a, b, cin, w1, w2);
	full_adder fa2(w1, w2, 0, w3, cout);
	
	// Assign the output of the second full adder to the sum output
	assign sum = w3;
	
endmodule
module full_adder (
	input a,
	input b,
	input cin,
	output sum,
	output carry_out
);
	// Define internal wires
	wire w1, w2, w3;
	
	// Calculate the sum using XOR gates and assign it to the sum output
	assign sum = a ^ b ^ cin;
	
	// Calculate the carry-out using AND and OR gates and assign it to the carry_out output
	assign carry_out = (a & b) | (a & cin) | (b & cin);
	
endmodule
