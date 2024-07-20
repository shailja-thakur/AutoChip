module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

// Internal wires
wire s1;
wire c1;
wire c2;

// Instantiate the full adder
full_adder FA(a, b, cin, s1, c1);
full_adder FA(s1, c1, 1'b0, sum, c2);

// Assign the carry out
assign cout = c2;

endmodule
module full_adder (
	input a,
	input b,
	input cin,
	output sum,
	output cout
);

// Internal wires
wire w1;
wire w2;

// Generate the sum
assign sum = a ^ b ^ cin;

// Generate the carry out
assign cout = (a & b) | (cin & (a ^ b));

endmodule
