module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);
	
	wire [3:0] carry;
	wire overflow;
	
	// Instantiate four full adders for each bit of the input and output
	full_adder fa0 (.a(x[0]), .b(y[0]), .cin(1'b0), .sum(sum[0]), .carry(carry[0]));
	full_adder fa1 (.a(x[1]), .b(y[1]), .cin(carry[0]), .sum(sum[1]), .carry(carry[1]));
	full_adder fa2 (.a(x[2]), .b(y[2]), .cin(carry[1]), .sum(sum[2]), .carry(carry[2]));
	full_adder fa3 (.a(x[3]), .b(y[3]), .cin(carry[2]), .sum(sum[3]), .carry(carry[3]));

	// Propagate the carry through all the full adders
	assign carry[3] = overflow;
	assign carry[2] = carry[3];
	assign carry[1] = carry[2];
	assign carry[0] = carry[1];
	
	// Calculate the overflow bit
	assign overflow = carry[3] ^ carry[2];
	
endmodule
module full_adder (
	input a, b, cin,
	output sum, carry
);
	
	// Implement the XOR gate
	assign sum = a ^ b ^ cin;
	
	// Implement the AND gates
	assign carry = (a & b) | (cin & (a ^ b));
	
endmodule
