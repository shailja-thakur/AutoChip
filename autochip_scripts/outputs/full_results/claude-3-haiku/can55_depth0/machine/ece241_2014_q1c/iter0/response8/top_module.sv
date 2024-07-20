module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    // Create an 8-bit wire to hold the sum
    wire [7:0] sum;

    // Assign the 8-bit sum
    assign sum = a + b;

    // Assign the 8-bit output s to the lower 8 bits of the sum
    assign s = sum[7:0];

    // Assign the overflow output
    assign overflow = (a[7] == b[7]) && (s[7] != a[7]);

endmodule
