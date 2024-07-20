module top_module(
    input a,
    input b,
    output out
);

    wire or_out;

    or(or_out, a, b);
    not(out, or_out);

endmodule
