module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    wire [7:0] sum;
    assign sum = a + b;
    assign s = sum;

    // Check for overflow: 
    // Overflow occurs if the sign bit of a and b are the same and the sign bit of the sum is different
    assign overflow = ~(a[7] ^ b[7]) & (a[7] ^ sum[7]);

endmodule
