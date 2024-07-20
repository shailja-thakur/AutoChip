module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);
    wire [7:0] sum; // Create an 8-bit wire for the sum

    assign sum = a + b; // Assign the sum of a and b to the wire

    assign s = sum[7:0]; // Assign the 8 least significant bits of sum to the output s

    assign overflow = (a[7] && b[7] && ~sum[7]) || (~a[7] && ~b[7] && sum[7]); // Assign the overflow output based on the logical expression

endmodule
