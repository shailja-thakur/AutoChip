module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

    // Perform the addition
    assign s = a + b;

    // Calculate the overflow
    // Overflow in twos complement occurs when adding two numbers with the same sign produces a result with a different sign
    assign overflow = ((a[7] == b[7]) && (s[7] != a[7]));

endmodule
