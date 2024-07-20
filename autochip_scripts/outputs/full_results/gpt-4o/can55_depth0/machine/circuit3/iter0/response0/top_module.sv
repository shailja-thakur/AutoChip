module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    // OR gate for inputs a and b
    wire or_ab;
    assign or_ab = a | b;

    // OR gate for inputs c and d
    wire or_cd;
    assign or_cd = c | d;

    // AND gate for the outputs of the two OR gates
    assign q = or_ab & or_cd;

endmodule
