module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

    wire or_ab, or_cd;

    // Bitwise OR for inputs a and b
    assign or_ab = a | b;

    // Bitwise OR for inputs c and d
    assign or_cd = c | d;

    // Bitwise AND of the results of the OR operations
    assign q = or_ab & or_cd;

endmodule
