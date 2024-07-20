module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    wire q_internal;

    and #(4) and_gate1 (
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .out(q_internal)
    );

    not not_gate1 (
        .a(q_internal),
        .out(q)
    );

endmodule
