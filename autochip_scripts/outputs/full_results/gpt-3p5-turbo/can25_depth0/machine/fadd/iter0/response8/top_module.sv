module top_module (
	input a,
	input b,
	input cin,
	output reg cout,
	output reg sum
);

	// assign statement to calculate the outputs
	assign {cout, sum} = a + b + cin >= 2 ? {1'b1, (a + b + cin) % 2} : {1'b0, a + b + cin};

endmodule
