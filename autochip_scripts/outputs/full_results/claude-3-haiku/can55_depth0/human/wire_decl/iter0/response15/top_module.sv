module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n
);

wire and1_out, and2_out;

// Implement the AND gates
and(and1_out, a, b);
and(and2_out, c, d);

// Implement the OR gate
or(out, and1_out, and2_out);

// Implement the NOT gate
not(out_n, out);

endmodule
