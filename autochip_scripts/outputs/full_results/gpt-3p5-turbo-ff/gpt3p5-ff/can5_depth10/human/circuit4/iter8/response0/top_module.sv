module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);
    // Intermediate wires
    wire w1, w2, w3;

    // First level of logic
    assign w1 = (~a & ~b & c & ~d) | (~a & ~b & ~c & d);

    // Second level of logic
    assign w2 = (a & ~b & c & ~d) | (a & b & ~c & d);

    // Third level of logic
    assign w3 = w1 | w2;

    // Final output
    assign q = w3;

endmodule
