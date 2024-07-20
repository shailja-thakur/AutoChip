module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    wire [7:0] sum;  // wire for the sum of the two inputs

    // assign the 8-bit output 's' to the 8 least significant bits of the sum
    assign s = sum[7:0];

    // assign the overflow output based on the logical expression
    assign overflow = (a[7] == b[7]) && (a[7] != s[7]);

    // adder logic to calculate the sum  of the two inputs
    assign sum = a + b;

endmodule
