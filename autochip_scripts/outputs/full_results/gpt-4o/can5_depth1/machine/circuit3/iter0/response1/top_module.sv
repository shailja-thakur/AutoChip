module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    wire ab_or, cd_or;

    // OR gate for inputs a and b
    assign ab_or = a | b;

    // OR gate for inputs c and d
    assign cd_or = c | d;

    // AND gate for the results of the two OR gates
    assign q = ab_or & cd_or;

endmodule
