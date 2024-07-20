module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    wire ab, cd;

    // Perform bitwise OR of inputs a and b
    assign ab = a | b;

    // Perform bitwise OR of inputs c and d
    assign cd = c | d;

    // Perform bitwise AND of the two ORs
    assign q = ab & cd;

endmodule
