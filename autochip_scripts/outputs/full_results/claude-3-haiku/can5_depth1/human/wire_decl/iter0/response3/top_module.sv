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
assign and1 = a & b;
assign and2 = c & d;

// Second layer: OR gate
assign out = and1 | and2;

// Inverted output
assign out_n = ~out;

endmodule
