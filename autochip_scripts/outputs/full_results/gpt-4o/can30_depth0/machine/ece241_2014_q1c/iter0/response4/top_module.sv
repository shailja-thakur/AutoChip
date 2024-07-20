module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    wire [8:0] sum; // 9-bit wire to store the sum including carry out

    assign sum = a + b; // Calculate 8-bit sum with possible carry out
    assign s = sum[7:0]; // Assign the 8 least significant bits to the output
    assign overflow = (a[7] == b[7]) && (a[7] != s[7]); // Check for overflow condition

endmodule
