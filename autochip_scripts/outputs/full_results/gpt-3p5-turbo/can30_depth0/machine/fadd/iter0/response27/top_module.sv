module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Internal wires
	wire sum_temp;
	wire cout_temp;

	// Calculate the sum
	assign sum_temp = (a + b + cin) % 2;

	// Calculate the carry-out
	assign cout_temp = (a + b + cin) >= 2 ? 1'b1 : 1'b0;

	// Output signals
	assign sum = sum_temp;
	assign cout = cout_temp;

endmodule
