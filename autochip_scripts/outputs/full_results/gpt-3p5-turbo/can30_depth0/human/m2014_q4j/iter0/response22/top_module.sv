module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);
	// Instantiate full adders
	wire [4:0] carry;
	
	full_adder adder0 (
		.x(x[0]),
		.y(y[0]),
		.cin(1'b0),
		.sum(sum[0]),
		.cout(carry[0])
	);
	
	full_adder adder1 (
		.x(x[1]),
		.y(y[1]),
		.cin(carry[0]),
		.sum(sum[1]),
		.cout(carry[1])
	);
	
	full_adder adder2 (
		.x(x[2]),
		.y(y[2]),
		.cin(carry[1]),
		.sum(sum[2]),
		.cout(carry[2])
	);
	
	full_adder adder3 (
		.x(x[3]),
		.y(y[3]),
		.cin(carry[2]),
		.sum(sum[3]),
		.cout(carry[3])
	);
	
	// Assign overflow bit
	assign sum[4] = carry[3];
	
endmodule
module full_adder (
	input x,
	input y,
	input cin,
	output sum,
	output cout
);
	
	assign sum = x ^ y ^ cin;
	assign cout = (x & y) | (x & cin) | (y & cin);
	
endmodule
