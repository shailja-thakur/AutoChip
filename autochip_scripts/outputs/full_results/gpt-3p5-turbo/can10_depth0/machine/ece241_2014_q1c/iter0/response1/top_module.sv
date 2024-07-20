module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    wire [7:0] sum;
    
    // Adding the two inputs
    assign sum = a + b;
    
    // Assigning the least significant 8 bits of the sum to the output s
    assign s = sum[7:0];
    
    // Checking for overflow
    assign overflow = (a[7] == b[7]) && (sum[7] != a[7]);

endmodule
