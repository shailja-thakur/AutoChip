module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);
    wire w1, w2, w3, w4, w5;

    and gate1 (w1, a, b);
    or gate2 (w2, c, d);
    nor gate3 (w3, w1, w1);
    not gate4 (w4, w2);
    xor gate5 (w5, w3, w4);
    assign q = w5;

endmodule
