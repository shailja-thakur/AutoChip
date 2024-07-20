module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire sum_tmp;
    wire carry1, carry2;

    // Full adder implementation
    assign sum_tmp = a ^ b ^ cin;
    assign carry1 = a & b;
    assign carry2 = a ^ b & cin;
    assign cout = carry1 | carry2;
    assign sum = sum_tmp;

endmodule
