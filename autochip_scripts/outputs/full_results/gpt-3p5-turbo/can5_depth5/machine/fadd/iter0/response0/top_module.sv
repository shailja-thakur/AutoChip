module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// wires for internal connections
	wire [1:0] sum_temp;
	wire carry;

	// assign statements
	assign {carry, sum_temp} = a + b + cin;
	assign cout = carry;
	assign sum = sum_temp[0];

endmodule
