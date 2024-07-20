module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

wire [8:0] sum;

// Add the two 8-bit numbers to produce a 9-bit result
assign sum = {a[7], a} + {b[7], b};

// Assign the 8-bit output
assign s = sum[7:0];

// Detect overflow
// Overflow occurs when the most significant bits of the operands are the same,
// but the most significant bit of the result is different.
assign overflow = (a[7] == b[7]) && (a[7] != sum[7]);

endmodule
