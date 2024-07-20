module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire w1, w2, w3;

    // Half adder for a + b
    xor(w1, a, b);
    and(w2, a, b);

    // Full adder with carry-in
    xor(sum, w1, cin);
    and(w3, w1, cin);
    or(cout, w2, w3);

endmodule
