module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	// Define 4 full adders
	wire [3:0] carry;
	wire [3:0] carry_out;
	wire [3:0] sum_out;

	full_adder fa0(x[0], y[0], 0, sum_out[0], carry_out[0]);
	full_adder fa1(x[1], y[1], carry_out[0], sum_out[1], carry_out[1]);
	full_adder fa2(x[2], y[2], carry_out[1], sum_out[2], carry_out[2]);
	full_adder fa3(x[3], y[3], carry_out[2], sum_out[3], carry_out[3]);

	// Assign outputs
	assign sum = {carry_out[3], sum_out};

endmodule
module full_adder (
	input x, 
	input y,
	input cin, 
	output sum, 
	output cout
);
	
	// Implement full adder logic
	assign sum = x ^ y ^ cin;
	assign cout = (x & y) | (x & cin) | (y & cin);

endmodule
