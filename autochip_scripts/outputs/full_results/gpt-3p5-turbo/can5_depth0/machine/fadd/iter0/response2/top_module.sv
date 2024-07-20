module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

	// Calculate the sum of a, b, and cin
	assign sum = (a + b + cin) % 2;
	
	// Determine if the sum is greater than or equal to 2
	assign cout = (a + b + cin) >= 2 ? 1'b1 : 1'b0;

endmodule
