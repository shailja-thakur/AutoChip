module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    // Intermediate 9-bit wire to hold the full sum including carry out
    wire [8:0] sum_full;

    // Perform 8-bit addition
    assign sum_full = a + b;

    // Assign the 8 least significant bits to output s
    assign s = sum_full[7:0];

    // Check for overflow 
    // Overflow occurs if there is a carry into the sign bit but not a carry out of the sign bit, or vice versa
    assign overflow = (a[7] == b[7]) && (s[7] != a[7]);

endmodule
