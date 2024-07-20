module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

wire or_ab, or_cd;

// Compute the bitwise OR of inputs a and b
assign or_ab = a | b;

// Compute the bitwise OR of inputs c and d
assign or_cd = c | d;

// Compute the bitwise AND of the two ORs
assign q = or_ab & or_cd;

endmodule
