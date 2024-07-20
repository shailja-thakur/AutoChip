module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    wire [8:0] sum;

    // Calculate sum of a and b with an extra bit for overflow
    assign sum = a + b;

    // Assign the 8 least significant bits to output s
    assign s = sum[7:0];

    // Check for overflow: 
    // Overflow occurs if the sign of a and b is the same but the sign of s is different
    assign overflow = (a[7] == b[7]) && (s[7] != a[7]);

endmodule
