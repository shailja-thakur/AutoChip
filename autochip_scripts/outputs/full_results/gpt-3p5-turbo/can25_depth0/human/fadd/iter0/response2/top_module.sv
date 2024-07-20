module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    // Declare internal signals
    wire s1, c1, c2;

    // Instantiate the first adder
    xor u1 (s1, a, b);
    and g1 (c1, a, b);
    xor u2 (sum, s1, cin);
    and g2 (c2, s1, cin);

    // Instantiate the second adder
    xor u3 (sum, sum, c1);
    and g3 (cout, c1, c2);    

endmodule
