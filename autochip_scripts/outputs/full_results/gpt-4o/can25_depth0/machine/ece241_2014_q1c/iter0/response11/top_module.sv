module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);
    wire [8:0] sum; // Extend the sum wire to 9 bits to accommodate carry out.

    assign sum = a + b;
    assign s = sum[7:0]; // Assign the least significant 8 bits to output s.

    // Overflow occurs if the sign of the result is different from the inputs when the inputs have the same sign.
    assign overflow = ((a[7] == b[7]) && (s[7] != a[7]));

endmodule
