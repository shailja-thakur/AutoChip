module top_module(
    input p1a,
    input p1b,
    input p1c,
    input p1d,
    output p1y,
    input p2a,
    input p2b,
    input p2c,
    input p2d,
    output p2y
);

    /* Gate 1 */
    wire g1a;
    wire g1b;
    wire g1c;
    wire g1d;
    wire g1y;

    nand_gate u1(
        .a(p1a),
        .b(p1b),
        .c(p1c),
        .d(p1d),
        .y(g1y)
    );

    /* Gate 2 */
    wire g2a;
    wire g2b;
    wire g2c;
    wire g2d;
    wire g2y;

    nand_gate u2(
        .a(p2a),
        .b(p2b),
        .c(p2c),
        .d(p2d),
        .y(g2y)
    );

endmodule
module nand_gate(
    input a,
    input b,
    input c,
    input d,
    output y
);
    assign y = ~(a & b & c & d);
endmodule
