module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);
    wire [8:0] sum; // Extend to 9 bits to detect overflow

    assign sum = a + b;
    
    // Assign the sum to the output bits
    assign s = sum[7:0];
    
    // Check for overflow
    assign overflow = (~a[7] & ~b[7] & sum[8]) | (a[7] & b[7] & ~sum[8]);

endmodule
