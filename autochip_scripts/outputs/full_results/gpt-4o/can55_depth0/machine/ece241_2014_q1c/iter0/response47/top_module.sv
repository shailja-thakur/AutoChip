module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);
    wire [8:0] sum;  // Create a 9-bit wire to store the sum including carry

    assign sum = a + b;        // Calculate the sum of a and b
    assign s = sum[7:0];       // Assign the lower 8-bits of sum to the output s
    assign overflow = (a[7] == b[7]) && (s[7] != a[7]);  // Check for overflow
    
endmodule
