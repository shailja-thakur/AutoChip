module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire c1, c2, s1;

    // Half adder for a + b
    xor(s1, a, b);
    and(c1, a, b);

    // Add cin to the sum
    xor(sum, s1, cin);
    and(c2, s1, cin);
    or(cout, c1, c2);

endmodule
