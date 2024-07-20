module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);
    wire [8:0] sum;

    // Sum the inputs, including carry out
    assign sum = a + b;

    // The 8-bit sum output
    assign s = sum[7:0];

    // Determine if there is an overflow
    assign overflow = (a[7] == b[7]) && (s[7] != a[7]);

endmodule
