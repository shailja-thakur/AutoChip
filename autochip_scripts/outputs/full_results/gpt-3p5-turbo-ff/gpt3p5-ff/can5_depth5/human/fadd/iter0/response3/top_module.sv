module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);
	// Declare internal signals
	wire s1, c1, s2, c2;
	
	// Instantiate the first half-adder
	half_adder ha1(a, b, s1, c1);
	
	// Instantiate the second half-adder
	half_adder ha2(s1, cin, sum, c2);
	
	// Generate the carry-out
	xor gate1(c1, c2, cout);
endmodule
module half_adder (
	input a,
	input b,
	output sum,
	output carry
);
	// Create the sum and carry-out signals
	assign sum = a ^ b;
	assign carry = a & b;
endmodule
