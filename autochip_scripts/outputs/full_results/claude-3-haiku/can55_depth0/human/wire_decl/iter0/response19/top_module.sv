module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n
);

wire and_out1, and_out2;

and(and_out1, a, b);
and(and_out2, c, d);

or(out, and_out1, and_out2);
not(out_n, out);

endmodule
