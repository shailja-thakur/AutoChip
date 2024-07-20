module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	wire c1, c2, c3;
	
	// First bit
	full_adder fa0 (
		.a(x[0]),
		.b(y[0]),
		.cin(1'b0), // No carry in for the first bit
		.sum(sum[0]),
		.cout(c1)
	);
	
	// Second bit
	full_adder fa1 (
		.a(x[1]),
		.b(y[1]),
		.cin(c1), // Carry from the previous bit
		.sum(sum[1]),
		.cout(c2)
	);
	
	// Third bit
	full_adder fa2 (
		.a(x[2]),
		.b(y[2]),
		.cin(c2), // Carry from the previous bit
		.sum(sum[2]),
		.cout(c3)
	);
	
	// Fourth bit
	full_adder fa3 (
		.a(x[3]),
		.b(y[3]),
		.cin(c3), // Carry from the previous bit
		.sum(sum[3]),
		.cout(sum[4]) // The final carry-out is the overflow bit
	);
	
endmodule
module full_adder (
	input a,
	input b,
	input cin,
	output sum,
	output cout
);
	assign sum = a ^ b ^ cin;
	assign cout = (a & b) | (b & cin) | (a & cin);
endmodule
