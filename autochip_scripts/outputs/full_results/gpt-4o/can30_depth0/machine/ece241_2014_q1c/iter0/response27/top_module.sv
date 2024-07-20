module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);
    // Declare an intermediate 8-bit wire for the sum
    wire [8:0] sum;

    // Sum the inputs, including an extra bit to check for overflow
    assign sum = a + b;
    
    // Assign the 8-bit result to output s
    assign s = sum[7:0];
    
    // Check for overflow: if both inputs have the same sign and the sign of the result is different, then overflow occurs
    assign overflow = (~a[7] & ~b[7] & sum[8]) | (a[7] & b[7] & ~sum[8]);

endmodule
