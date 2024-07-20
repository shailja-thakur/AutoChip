module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire w1, w2, w3;

    and g1 (w1, a, b);
    and g2 (w2, a, cin);
    and g3 (w3, b, cin);

    or g4 (sum, w1, w2, w3);

    and g5 (cout, w1, w2);
    or g6 (cout, w1, w3);
    or g7 (cout, w2, w3);

endmodule
