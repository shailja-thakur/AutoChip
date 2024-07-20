module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);
    wire [8:0] sum;  // 9-bit wire to hold the sum to catch overflow

    // Add the two 8-bit numbers and store the result in a 9-bit wire
    assign sum = a + b;

    // The 8-bit output is the lower 8 bits of the sum
    assign s = sum[7:0];
    
    // Check for overflow. Overflow occurs when the sign of the result is different from both inputs' signs.
    // Overflow bit would be '1' when:
    // 1. Both inputs have the same sign (a[7] == b[7])
    // 2. The sign of the result is different from the inputs (s[7] != a[7])
    assign overflow = (a[7] == b[7]) && (s[7] != a[7]);

endmodule
