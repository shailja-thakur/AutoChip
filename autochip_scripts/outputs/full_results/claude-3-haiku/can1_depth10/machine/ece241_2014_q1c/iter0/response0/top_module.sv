module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    wire [8:0] sum;

    // Calculate the sum of the two inputs
    assign sum = a + b;

    // Assign the 8 least significant bits of the sum to the output s
    assign s = sum[7:0];

    // Assign the overflow output based on the sign of the inputs and the sum
    assign overflow = (a[7] == b[7]) && (a[7] != sum[7]);

endmodule
