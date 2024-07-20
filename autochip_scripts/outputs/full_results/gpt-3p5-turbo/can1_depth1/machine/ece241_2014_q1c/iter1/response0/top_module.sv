module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);
    wire [8:0] sum; // Increase width to 9 to avoid overflow
    
    // Assign the sum of inputs 'a' and 'b' to the 'sum' wire
    assign sum = a + b;
    
    // Assign the 8 least significant bits of 'sum' to the output 's'
    assign s = sum[7:0];
    
    // Assign the overflow output based on the logical expression
    assign overflow = (a[7] != b[7]) & (s[7] != a[7]); // Use '!=' operator instead of '^'
    
endmodule
