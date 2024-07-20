module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n
);

wire and_1, and_2;

// First layer of AND gates
and(and_1, a, b);
and(and_2, c, d);

// Second layer of OR gate
or(out, and_1, and_2);

// Inverted output
not(out_n, out);

endmodule
