module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Internal wires to hold the intermediate results
	wire ab_sum, ab_carry, sum_carry;

	// First half adder
	assign ab_sum = a ^ b;         // Sum of a and b
	assign ab_carry = a & b;       // Carry from adding a and b

	// Second half adder (adding cin to the sum of a and b)
	assign sum = ab_sum ^ cin;     // Final sum of the full adder
	assign sum_carry = ab_sum & cin; // Carry from adding cin to the sum of a and b

	// Final carry out
	assign cout = ab_carry | sum_carry; // Final carry out of the full adder

endmodule
