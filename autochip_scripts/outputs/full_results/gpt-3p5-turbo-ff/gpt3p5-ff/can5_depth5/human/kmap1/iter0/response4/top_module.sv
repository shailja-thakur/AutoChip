module top_module(
    input a,
    input b,
    input c,
    output out
);

    wire d;
    wire e;
    wire f;

    and gate1 (a, b, d);
    and gate2 (b, c, e);
    or gate3 (d, e, f);
    and gate4 (f, c, out);

endmodule
module and(
    input a,
    input b,
    output y
);
    assign y = a & b;
endmodule
module or(
    input a,
    input b,
    output y
);
    assign y = a | b;
endmodule
