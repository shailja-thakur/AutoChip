module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    wire w1, w2, w3, w4, w5, w6, w7, w8;

    and gate1(w1, a, b);
    and gate2(w2, c, d);
    or gate3(w3, w1, w2);
    not gate4(w4, w3);
    or gate5(w5, b, c);
    or gate6(w6, d, a);
    not gate7(w7, w5);
    or gate8(w8, w6, w7);
    and gate9(q, w4, w8);

endmodule
