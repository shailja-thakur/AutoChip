module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    wire ab_or;
    wire cd_or;

    // Compute the OR of inputs a and b
    assign ab_or = a | b;

    // Compute the OR of inputs c and d
    assign cd_or = c | d;

    // Compute the AND of the two ORs to produce the output q
    assign q = ab_or & cd_or;

endmodule
