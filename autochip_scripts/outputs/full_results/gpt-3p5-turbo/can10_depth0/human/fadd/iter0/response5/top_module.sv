module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);
	// Create intermediate wires to hold temporary values
	wire s1, s2, c1, c2;
	
	// Instantiate two half adders to handle the first and second bit additions
	half_adder HA1 (a, b, s1, c1);
	half_adder HA2 (s1, cin, sum, c2);
	
	// Implement the carry out logic
	assign cout = c1 | c2;
	
	// Define the half adder module
	module half_adder (
		input a,
		input b,
		output sum,
		output carry
	);
		wire s, c;
		
		// Implement the XOR and AND logic for the half adder
		assign sum = a ^ b;
		assign carry = a & b;
	endmodule
