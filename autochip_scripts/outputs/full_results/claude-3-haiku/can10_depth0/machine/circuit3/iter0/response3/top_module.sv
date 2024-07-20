module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

wire or_ab, or_cd;

// Perform the bitwise OR of inputs a and b
assign or_ab = a | b;

// Perform the bitwise OR of inputs c and d
assign or_cd = c | d;

// Perform the bitwise AND of the two ORs
assign q = or_ab & or_cd;

endmodule
