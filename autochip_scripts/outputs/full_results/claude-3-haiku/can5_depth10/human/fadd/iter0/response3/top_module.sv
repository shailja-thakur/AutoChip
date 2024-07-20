module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire w1, w2, w3;

    // Sum
    xor (sum, a, b, cin);

    // Carry
    and (w1, a, b);
    and (w2, a, cin);
    and (w3, b, cin);
    or (cout, w1, w2, w3);

endmodule
