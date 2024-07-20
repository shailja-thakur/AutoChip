module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

wire [8:0] sum;

// Add the two 8-bit numbers to produce a 9-bit result
assign sum = {1'b0, a} + {1'b0, b};

// Assign the 8-bit sum output
assign s = sum[7:0];

// Detect overflow condition
// Overflow occurs when the signs of the two operands are the same
// and the sign of the result is different from the signs of the operands
assign overflow = (a[7] == b[7]) && (a[7] != sum[7]);

endmodule
