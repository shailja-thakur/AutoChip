module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);
    wire or_ab;
    wire or_cd;

    // Perform bitwise OR for inputs a and b
    assign or_ab = a | b;

    // Perform bitwise OR for inputs c and d
    assign or_cd = c | d;

    // Perform bitwise AND for the results of the OR operations
    assign q = or_ab & or_cd;

endmodule
