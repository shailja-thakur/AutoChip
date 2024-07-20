module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    wire [8:0] sum; // Create 9-bit wire to hold the sum including carry out

    assign sum = a + b; // Perform the addition
    assign s = sum[7:0]; // Assign the 8 least significant bits to s

    // Check for overflow: sign of a is same as sign of b, but different from sign of s
    assign overflow = (~a[7] & ~b[7] & s[7]) | (a[7] & b[7] & ~s[7]);

endmodule
