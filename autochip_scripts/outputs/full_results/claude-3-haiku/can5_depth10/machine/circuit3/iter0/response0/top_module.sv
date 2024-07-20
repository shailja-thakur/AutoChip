module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

wire ab_or, cd_or;

// Bitwise OR of inputs a and b
assign ab_or = a | b;

// Bitwise OR of inputs c and d  
assign cd_or = c | d;

// Bitwise AND of the two ORs
assign q = ab_or & cd_or;

endmodule
