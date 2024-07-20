module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n
);

wire and1, and2;

// First layer: AND gates
and and_gate1(and1, a, b);
and and_gate2(and2, c, d);

// Second layer: OR gate
or or_gate(out, and1, and2);

// Inverted output
not not_gate(out_n, out);

endmodule
