module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    wire [8:0] sum;

    // Add the two 8-bit inputs
    assign sum = a + b;

    // Assign the 8-bit sum output
    assign s = sum[7:0];

    // Assign the overflow output
    assign overflow = (a[7] == b[7]) && (sum[7] != a[7]);

endmodule
