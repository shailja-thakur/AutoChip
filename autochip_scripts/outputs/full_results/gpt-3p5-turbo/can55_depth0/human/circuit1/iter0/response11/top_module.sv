module top_module (
    input a,
    input b,
    output q
);
    assign q = (a & ~b) | (a & b);  // Performs AND operation between a and not b, then performs AND operation between a and b, finally performs OR operation between the two results.
endmodule
