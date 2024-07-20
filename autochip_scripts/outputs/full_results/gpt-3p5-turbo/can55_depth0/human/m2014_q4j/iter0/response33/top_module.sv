module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	// Declare internal wires for connecting full adders
	wire [3:0] carry;
	wire [3:0] s;

	// Instantiate four full adders
	full_adder fa0(x[0], y[0], 1'b0, s[0], carry[1]);
	full_adder fa1(x[1], y[1], carry[1], s[1], carry[2]);
	full_adder fa2(x[2], y[2], carry[2], s[2], carry[3]);
	full_adder fa3(x[3], y[3], carry[3], s[3], carry[4]);

	// Assign sum output
	assign sum[0] = s[0];
	assign sum[1] = s[1];
	assign sum[2] = s[2];
	assign sum[3] = s[3];
	assign sum[4] = carry[4];

endmodule
module full_adder (
	input a,
	input b,
	input cin,
	output s,
	output cout
);

	// Internal wires for intermediate calculations
	wire w1, w2, w3;

	// Calculate sum and carry out
	assign s = a ^ b ^ cin;
	assign w1 = a & b;
	assign w2 = a & cin;
	assign w3 = b & cin;
	assign cout = w1 | w2 | w3;

endmodule
