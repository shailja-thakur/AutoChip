module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Calculate the sum
	assign sum = (a + b + cin) % 2;

	// Calculate the carry-out bit
	assign cout = (a + b + cin) >= 2 ? 1'b1 : 1'b0;

endmodule
