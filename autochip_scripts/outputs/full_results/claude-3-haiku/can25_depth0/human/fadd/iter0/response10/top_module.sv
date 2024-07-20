module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire carry1, carry2, carry3;

    // Half adder for a + b
    xor (sum_ab, a, b);
    and (carry1, a, b);

    // Half adder for sum_ab + cin
    xor (sum, sum_ab, cin);
    and (carry2, sum_ab, cin);

    // Combine the two carry bits
    or (carry3, carry1, carry2);
    assign cout = carry3;

endmodule
