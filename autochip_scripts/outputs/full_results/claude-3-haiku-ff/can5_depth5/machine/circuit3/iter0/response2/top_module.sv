module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

wire ab, cd;

// Compute the bitwise OR of a and b
assign ab = a | b;

// Compute the bitwise OR of c and d  
assign cd = c | d;

// Compute the bitwise AND of the two ORs
assign q = ab & cd;

endmodule
