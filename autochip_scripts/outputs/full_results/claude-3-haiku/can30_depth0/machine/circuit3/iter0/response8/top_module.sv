module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

wire a_or_b;
wire c_or_d;

or (a_or_b, a, b);
or (c_or_d, c, d);
and (q, a_or_b, c_or_d);

endmodule
