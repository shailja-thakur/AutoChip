module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);
	// Wire to calculate the sum
	wire [1:0] sum_wire = a + b + cin;
	
	// Assign statement to calculate the outputs
	assign {cout, sum} = {sum_wire[1], sum_wire[0]};
endmodule
