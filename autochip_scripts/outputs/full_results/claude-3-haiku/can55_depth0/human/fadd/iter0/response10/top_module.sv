module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire s1, c1, c2;

    // Half Adder 1
    xor (s1, a, b);
    and (c1, a, b);

    // Half Adder 2
    xor (sum, s1, cin);
    and (c2, s1, cin);

    // Full Adder
    or (cout, c1, c2);

endmodule
