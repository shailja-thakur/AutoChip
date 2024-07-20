module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);
	// Declare internal signals
	wire carry;
	wire [3:0] s;

	// Instantiate full adder modules
	full_adder fa0(.x(x[0]), .y(y[0]), .cin(0), .sum(s[0]), .cout(carry));
	full_adder fa1(.x(x[1]), .y(y[1]), .cin(carry), .sum(s[1]), .cout(carry));
	full_adder fa2(.x(x[2]), .y(y[2]), .cin(carry), .sum(s[2]), .cout(carry));
	full_adder fa3(.x(x[3]), .y(y[3]), .cin(carry), .sum(s[3]), .cout(carry));

	// Assign output signals
	assign sum = {carry, s};

	// Define full adder module
	module full_adder (
		input x,
		input y,
		input cin,
		output sum,
		output cout
	);
		assign {sum,cout} = x + y + cin;
	endmodule
