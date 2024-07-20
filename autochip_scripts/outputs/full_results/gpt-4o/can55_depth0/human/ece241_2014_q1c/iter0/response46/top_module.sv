module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);
    
    assign s = a + b;
    
    // Overflow occurs when adding two positive numbers results in a negative number,
    // or adding two negative numbers results in a positive number.
    assign overflow = (~a[7] & ~b[7] & s[7]) | (a[7] & b[7] & ~s[7]);
    
endmodule
