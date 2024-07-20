module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);
    // Internal signals to hold intermediate sum and carry
    wire sum_ab, carry_ab, carry_sum;

    // First stage of computation
    assign sum_ab = a ^ b;
    assign carry_ab = a & b;

    // Second stage of computation
    assign sum = sum_ab ^ cin;
    assign carry_sum = sum_ab & cin;

    // Final carry out
    assign cout = carry_ab | carry_sum;

endmodule
