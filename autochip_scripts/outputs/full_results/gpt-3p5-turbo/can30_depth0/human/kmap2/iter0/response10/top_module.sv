module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    wire w1, w2, w3, w4, w5, w6;

    not_x1 u1 (
        .in(a),
        .out(w1)
    );

    not_x1 u2 (
        .in(b),
        .out(w2)
    );

    not_x1 u3 (
        .in(c),
        .out(w3)
    );

    not_x1 u4 (
        .in(d),
        .out(w4)
    );

    and_x1 u5 (
        .a(w1),
        .b(w2),
        .out(w5)
    );

    and_x1 u6 (
        .a(w3),
        .b(w2),
        .out(w6)
    );

    and_x1 u7 (
        .a(w4),
        .b(w6),
        .out(out)
    );

endmodule
