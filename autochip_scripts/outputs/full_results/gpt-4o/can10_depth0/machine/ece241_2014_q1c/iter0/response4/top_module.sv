module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    wire [8:0] sum; // Create a 9-bit wire to hold the sum including carry-out

    assign sum = a + b;
    assign s = sum[7:0]; // Assign the 8 least significant bits to s

    // Check for overflow: If the sign bit of a and b are the same but different from the sign bit of s
    assign overflow = (~a[7] & ~b[7] & sum[8]) | (a[7] & b[7] & ~sum[8]);
    
endmodule
