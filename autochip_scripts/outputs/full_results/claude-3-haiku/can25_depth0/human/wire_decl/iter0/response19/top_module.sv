module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n
);

wire and1_out, and2_out, or_out;

and and1(and1_out, a, b);
and and2(and2_out, c, d);

or or1(or_out, and1_out, and2_out);

assign out = or_out;
assign out_n = ~out;

endmodule
