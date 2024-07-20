module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    // Create an 8-bit wire to hold the sum of the two inputs
    wire [7:0] sum;

    // Assign the sum of the two inputs to the sum wire
    assign sum = a + b;

    // Assign the 8 least significant bits of the sum to the s output
    assign s = sum[7:0];

    // Assign the overflow output based on the condition:
    // If the two inputs have the same sign and the sign of the output is different,
    // then set the overflow bit to 1, otherwise set it to 0.
    assign overflow = (a[7] == b[7]) && (sum[7] != a[7]);

endmodule
