module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n );

    // Intermediate wires
    wire w1, w2;

    // First layer: AND gates
    assign w1 = a & b;
    assign w2 = c & d;

    // Second layer: OR gate
    assign out = w1 | w2;

    // Inverted output
    assign out_n = ~out;

endmodule
