module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

    wire or_ab;
    wire or_cd;

    // Logic for OR gates
    assign or_ab = a | b;
    assign or_cd = c | d;

    // Logic for AND gate
    assign q = or_ab & or_cd;

endmodule
