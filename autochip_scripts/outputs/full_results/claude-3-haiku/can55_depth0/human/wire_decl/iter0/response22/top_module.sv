module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n
);

wire and1, and2;

and(and1, a, b);
and(and2, c, d);
or(out, and1, and2);
not(out_n, out);

endmodule
