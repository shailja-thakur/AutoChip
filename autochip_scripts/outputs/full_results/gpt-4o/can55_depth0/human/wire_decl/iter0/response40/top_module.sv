module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n
);
    // Declare intermediate wires
    wire temp1, temp2;

    // First layer: AND gates
    assign temp1 = a & b;
    assign temp2 = c & d;

    // Second layer: OR gate
    assign out = temp1 | temp2;

    // Inverted output
    assign out_n = ~out;

endmodule
