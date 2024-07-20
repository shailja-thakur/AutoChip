module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

wire ab, cd;

// Bitwise OR of inputs a and b
assign ab = a | b;

// Bitwise OR of inputs c and d  
assign cd = c | d;

// Bitwise AND of the two ORs
assign q = ab & cd;

endmodule
