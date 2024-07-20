module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n
);

wire and_ab, and_cd;

// First layer: AND gates
and and1(and_ab, a, b);
and and2(and_cd, c, d);

// Second layer: OR gate
or or1(out, and_ab, and_cd);

// Inverted output
not not1(out_n, out);

endmodule
