module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n
);

wire intermediate_wire1, intermediate_wire2;

and(intermediate_wire1, a, b);
and(intermediate_wire2, c, d);

or(out, intermediate_wire1, intermediate_wire2);
not(out_n, out);

endmodule
