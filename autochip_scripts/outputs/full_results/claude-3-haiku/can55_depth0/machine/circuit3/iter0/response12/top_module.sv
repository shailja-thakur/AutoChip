module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

wire ab, cd;

// Implement the bitwise OR of a and b
or(ab, a, b);

// Implement the bitwise OR of c and d
or(cd, c, d);

// Implement the bitwise AND of the two ORs
and(q, ab, cd);

endmodule
