module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);
    wire [8:0] sum; // A 9-bit wire to hold the intermediate sum

    assign sum = {1'b0, a} + {1'b0, b}; // Perform the addition with zero padding to detect overflow
    assign s = sum[7:0]; // Assign the least significant 8 bits to 's'

    // Check for overflow: if the sign bits of a and b are the same, 
    // but the sign bit of s is different from a and b, overflow occurs
    assign overflow = (a[7] == b[7]) && (a[7] != s[7]);

endmodule
