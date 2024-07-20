module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);
    
    // Intermediate 9-bit wire to store the sum of a and b
    wire [8:0] sum;

    // Perform 8-bit addition and store the result in sum
    assign sum = a + b;

    // Assign the 8 least significant bits of sum to s
    assign s = sum[7:0];

    // Check for overflow: occurs if the sign of a and b are the same and differ from the sign of the sum
    assign overflow = (a[7] == b[7]) && (s[7] != a[7]);

endmodule
