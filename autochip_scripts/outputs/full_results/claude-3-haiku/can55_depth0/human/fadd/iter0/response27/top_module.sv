module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire s1, c1, c2;

    // Half adder for the sum
    xor(sum, a, b, cin);

    // Half adder for the carry
    and(c1, a, b);
    and(c2, a, cin);
    and(c3, b, cin);
    or(cout, c1, c2, c3);

endmodule
