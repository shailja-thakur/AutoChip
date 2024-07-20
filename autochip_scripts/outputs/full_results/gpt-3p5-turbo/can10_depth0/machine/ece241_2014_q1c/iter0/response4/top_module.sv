module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    wire [7:0] sum;
    assign sum = a + b;
    
    assign s = sum[7:0]; // Assigning the 8 least significant bits of sum to output s
    
    assign overflow = (a[7] == b[7]) && (sum[7] != a[7]); // Checking for overflow condition

endmodule
