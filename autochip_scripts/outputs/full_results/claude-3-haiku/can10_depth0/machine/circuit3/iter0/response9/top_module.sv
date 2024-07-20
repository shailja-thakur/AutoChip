module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    wire or_ab, or_cd;

    // Implement the OR gates for inputs a, b and c, d
    assign or_ab = a | b;
    assign or_cd = c | d;

    // Implement the AND gate for the outputs of the OR gates
    assign q = or_ab & or_cd;

endmodule
