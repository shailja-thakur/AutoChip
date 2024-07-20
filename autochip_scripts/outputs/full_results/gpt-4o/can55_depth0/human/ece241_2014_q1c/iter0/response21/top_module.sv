module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    // Perform the addition
    assign s = a + b;
    
    // Compute the overflow: occurs if sign of a and b is same and the sign of sum is different
    assign overflow = (~a[7] & ~b[7] & s[7]) | (a[7] & b[7] & ~s[7]);
    
endmodule
