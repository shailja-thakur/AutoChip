module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

    // Internal wire
    wire w1;

    // Calculating the sum
    assign sum = (a + b + cin) % 2;

    // Calculating the carry-out
    assign w1 = a + b + cin;
    assign cout = (w1 >= 2) ? 1'b1 : 1'b0;

endmodule
