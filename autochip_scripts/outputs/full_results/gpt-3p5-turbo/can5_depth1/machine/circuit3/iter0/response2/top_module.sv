module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    // Assign the bitwise OR of inputs a and b to a temporary signal ab_or
    wire ab_or;
    assign ab_or = a | b;
    
    // Assign the bitwise OR of inputs c and d to a temporary signal cd_or
    wire cd_or;
    assign cd_or = c | d;
    
    // Assign the bitwise AND of signals ab_or and cd_or to the output q
    assign q = ab_or & cd_or;
    
endmodule
