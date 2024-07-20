module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire s1, c1, c2;

    // Half Adder for a + b
    xor(s1, a, b);
    and(c1, a, b);

    // Full Adder with carry-in
    xor(sum, s1, cin);
    and(c2, s1, cin);
    or(cout, c1, c2);

endmodule
