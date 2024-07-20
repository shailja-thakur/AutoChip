module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);
    
    wire [8:0] sum; // Extend the width to 9 bits to capture overflow

    assign sum = a + b;
    assign s = sum[7:0]; // Assign the least significant 8 bits to s
    assign overflow = ((a[7] == b[7]) && (a[7] != s[7]));

endmodule
