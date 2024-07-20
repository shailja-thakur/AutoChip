module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

wire [8:0] sum;

// Add the two 8-bit numbers to produce a 9-bit sum
assign sum = {a[7], a} + {b[7], b};

// Assign the 8-bit sum output
assign s = sum[7:0];

// Detect overflow
// Overflow occurs when the two most significant bits of the 9-bit sum differ
assign overflow = sum[8] ^ sum[7];

endmodule
