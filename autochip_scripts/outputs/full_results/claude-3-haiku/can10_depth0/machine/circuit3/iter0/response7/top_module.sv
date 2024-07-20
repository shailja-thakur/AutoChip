module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    wire ab, cd;

    or (ab, a, b);
    or (cd, c, d);
    and (q, ab, cd);

endmodule
