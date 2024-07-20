module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n
);

// Declare the intermediate wires
wire and_out1, and_out2;

// Implement the first layer of AND gates
and(and_out1, a, b);
and(and_out2, c, d);

// Implement the second layer of OR gate
or(out, and_out1, and_out2);

// Implement the inverted output
not(out_n, out);

endmodule
