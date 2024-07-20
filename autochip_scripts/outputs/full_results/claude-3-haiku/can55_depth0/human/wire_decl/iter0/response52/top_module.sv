module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n
);

wire and_1;
wire and_2;

and(and_1, a, b);
and(and_2, c, d);

or(out, and_1, and_2);
not(out_n, out);

endmodule
