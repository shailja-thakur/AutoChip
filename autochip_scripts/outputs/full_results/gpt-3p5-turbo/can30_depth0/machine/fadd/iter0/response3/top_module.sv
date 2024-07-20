module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// internal wire declaration
	wire [1:0] sum_wire;

	// internal assign statement
	assign {cout, sum_wire[0]} = a + b + cin;

	// assign statements to calculate cout and sum
	assign cout = (sum_wire[0] >= 2'b10) ? 1'b1 : 1'b0;
	assign sum = sum_wire[0] % 2;

endmodule
