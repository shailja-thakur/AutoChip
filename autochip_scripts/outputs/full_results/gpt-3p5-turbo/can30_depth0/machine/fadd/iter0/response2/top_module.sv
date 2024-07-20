module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Declare internal wire for sum calculation
	wire [1:0] add_temp = a + b + cin;

	// Calculate carry-out and assign sum
	assign cout = (add_temp >= 2);
	assign sum = add_temp[0];

endmodule
