module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);
	// Define signals for the full adder
	wire [3:0] carry;
	wire [3:0] sum_out;

	// Instantiate the full adders and connect inputs/outputs
	full_adder fa0(x[0], y[0], 0, sum[0], carry[0]);
	full_adder fa1(x[1], y[1], carry[0], sum[1], carry[1]);
	full_adder fa2(x[2], y[2], carry[1], sum[2], carry[2]);
	full_adder fa3(x[3], y[3], carry[2], sum[3], carry[3]);

	// Assign the overflow bit
	assign sum[4] = carry[3];

endmodule
module full_adder (
	input a,
	input b,
	input cin,
	output s,
	output cout
);
	// Define internal signals
	wire s1, s2;
	
	// Generate the sum bit
	xor (s1, a, b);
	xor (s, cin, s1);

	// Generate the carry bit
	or (s2, a, b);
	and (cout, cin, s2);

endmodule
