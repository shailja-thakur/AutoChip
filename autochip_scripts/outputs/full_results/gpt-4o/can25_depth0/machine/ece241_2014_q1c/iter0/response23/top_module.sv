module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    wire [8:0] sum; // Create a wire to hold the sum of a and b plus carry bit

    assign sum = a + b; // Add a and b, result stored in sum
    assign s = sum[7:0]; // Assign least significant 8 bits to output s
    assign overflow = (a[7] == b[7]) && (s[7] != a[7]); // Check for overflow

endmodule
