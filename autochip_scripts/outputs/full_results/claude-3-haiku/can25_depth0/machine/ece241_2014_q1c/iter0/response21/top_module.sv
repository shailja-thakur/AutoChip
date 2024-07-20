module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    wire [8:0] sum;

    // Calculate the sum of the two inputs
    assign sum = a + b;

    // Assign the 8-bit output, s, to the 8 least significant bits of the sum
    assign s = sum[7:0];

    // Assign the overflow output based on the sign of the inputs and the sum
    assign overflow = (a[7] == b[7]) && (s[7] != a[7]);

endmodule
