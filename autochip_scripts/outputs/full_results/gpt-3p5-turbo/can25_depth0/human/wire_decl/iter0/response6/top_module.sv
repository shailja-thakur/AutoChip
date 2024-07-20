module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n );

    wire intermediate_1;
    wire intermediate_2;

    and (intermediate_1, a, b);
    and (intermediate_2, c, d);
    or (out, intermediate_1, intermediate_2);
    not (out_n, out);

endmodule
