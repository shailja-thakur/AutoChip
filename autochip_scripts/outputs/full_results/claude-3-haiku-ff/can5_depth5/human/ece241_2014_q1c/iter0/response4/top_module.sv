module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    // Add the two 8-bit numbers
    wire [8:0] sum = {1'b0, a} + {1'b0, b};

    // Assign the 8-bit sum to the output
    assign s = sum[7:0];

    // Check for signed overflow
    // Overflow occurs if the signs of the operands are the same,
    // but the sign of the result is different
    assign overflow = (a[7] == b[7]) && (a[7] != sum[7]);

endmodule
