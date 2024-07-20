module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);
    // Perform the addition
    assign s = a + b;
    
    // Compute the overflow for 2's complement addition
    assign overflow = ~(a[7] ^ b[7]) & (a[7] ^ s[7]);
endmodule
