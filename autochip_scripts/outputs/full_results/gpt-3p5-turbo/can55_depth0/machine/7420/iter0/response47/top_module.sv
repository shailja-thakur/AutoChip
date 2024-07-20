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

    wire p1, p2;

    andgate u1(
        .a(p1a),
        .b(p1b),
        .c(p1c),
        .d(p1d),
        .y(p1)
    );

    andgate u2(
        .a(p2a),
        .b(p2b),
        .c(p2c),
        .d(p2d),
        .y(p2)
    );

    notgate inv1(
        .a(p1),
        .y(p1y)
    );

    notgate inv2(
        .a(p2),
        .y(p2y)
    );
endmodule
module andgate(
    input a,
    input b,
    input c,
    input d,
    output y
);
    assign y = a & b & c & d;
endmodule
module notgate(
    input a,
    output y
);
    assign y = ~a;
endmodule
