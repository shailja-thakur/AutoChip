module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire w1, w2, w3;
    xor gate1(w1, a, b);
    xor gate2(sum, w1, cin);
    and gate3(w2, a, b);
    and gate4(w3, w1, cin);
    or gate5(cout, w2, w3);

endmodule
