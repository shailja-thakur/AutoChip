module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n );

    // Declare intermediate wires
    wire and1_out;
    wire and2_out;

    // First layer: AND gates
    assign and1_out = a & b;
    assign and2_out = c & d;

    // Second layer: OR gate
    assign out = and1_out | and2_out;

    // Inverted output
    assign out_n = ~out;

endmodule
