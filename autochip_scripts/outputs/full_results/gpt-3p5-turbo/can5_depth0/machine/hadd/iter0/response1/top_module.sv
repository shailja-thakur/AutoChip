module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// Declare internal signals
	wire [1:0] add_output;
	wire carry_out;

	// Adder logic
	assign {carry_out, sum} = a + b;

	// Output assignments
	assign cout = carry_out;
	assign add_output = {sum, carry_out};

endmodule
