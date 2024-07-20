module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n
);

wire and_ab, and_cd;

and(and_ab, a, b);
and(and_cd, c, d);
or(out, and_ab, and_cd);
not(out_n, out);

endmodule
