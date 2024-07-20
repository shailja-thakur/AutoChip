module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    wire [8:0] sum;

    // Add the two 8-bit inputs, a and b, and store the 9-bit result in sum
    assign sum = a + b;

    // Assign the 8 least significant bits of sum to the output s
    assign s = sum[7:0];

    // Assign the overflow output
    assign overflow = (a[7] == b[7]) && (s[7] != a[7]);

endmodule
