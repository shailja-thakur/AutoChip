module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    wire [8:0] sum;
    assign sum = a + b;
    assign s = sum[7:0];

    // Check if the sign of a and b are the same, and the sign of s is different
    assign overflow = ((a[7] == b[7]) && (s[7] != a[7]));

endmodule
