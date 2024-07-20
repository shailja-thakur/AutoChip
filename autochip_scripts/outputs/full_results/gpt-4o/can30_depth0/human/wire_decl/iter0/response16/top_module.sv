module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n
);

    wire and1_out;
    wire and2_out;

    and u1 (and1_out, a, b);
    and u2 (and2_out, c, d);
    or u3 (out, and1_out, and2_out);
    not u4 (out_n, out);

endmodule
