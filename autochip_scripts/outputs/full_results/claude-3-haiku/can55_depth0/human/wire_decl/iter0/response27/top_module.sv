module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n
);

wire intermediate1, intermediate2;

and(intermediate1, a, b);
and(intermediate2, c, d);
or(out, intermediate1, intermediate2);
not(out_n, out);

endmodule
