module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    wire [8:0] sum;  // Create a 9-bit wire to accommodate the overflow

    // Perform the addition
    assign sum = a + b;

    // Assign the 8-bit output to the 8 least significant bits of the sum
    assign s = sum[7:0];

    // Check for overflow: if the sign bits of a and b are the same,
    // but the sign bit of the sum is different, then overflow occurred.
    assign overflow = (a[7] == b[7]) && (a[7] != sum[8]);

endmodule
