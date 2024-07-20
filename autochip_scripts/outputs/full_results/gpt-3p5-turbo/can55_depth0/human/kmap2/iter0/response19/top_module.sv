module top_module (
    input a,
    input b,
    input c,
    input d,
    output out
);

    wire w1;
    wire w2;

    nand n1 (w1, a, ~b);
    nand n2 (w2, ~a, ~b);
    nand n3 (out, w1, w2);

endmodule
