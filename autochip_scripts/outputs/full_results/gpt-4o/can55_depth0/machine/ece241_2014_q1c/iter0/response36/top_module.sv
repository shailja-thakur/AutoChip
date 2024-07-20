module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    wire [8:0] sum;

    // Calculate sum
    assign sum = a + b;
    
    // Assign the 8 least significant bits to s
    assign s = sum[7:0];
    
    // Check for overflow
    assign overflow = (~a[7] & ~b[7] & s[7]) | (a[7] & b[7] & ~s[7]);

endmodule
