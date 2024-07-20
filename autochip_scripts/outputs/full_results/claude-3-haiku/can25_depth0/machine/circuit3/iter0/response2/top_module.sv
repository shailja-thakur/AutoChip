module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

    wire ab_or, cd_or;

    // Calculate the bitwise OR of a and b
    assign ab_or = a | b;

    // Calculate the bitwise OR of c and d
    assign cd_or = c | d;

    // Calculate the bitwise AND of the two ORs
    assign q = ab_or & cd_or;

endmodule
