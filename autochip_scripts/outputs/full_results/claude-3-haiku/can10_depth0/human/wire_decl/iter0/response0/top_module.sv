module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n
);

wire and1_out, and2_out, or_out;

// First layer: two AND gates
and(and1_out, a, b);
and(and2_out, c, d);

// Second layer: OR gate
or(or_out, and1_out, and2_out);

// Assign outputs
assign out = or_out;
assign out_n = ~or_out;

endmodule
