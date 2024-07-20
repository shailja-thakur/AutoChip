module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

// Add the two 8-bit numbers
wire [8:0] sum = {1'b0, a} + {1'b0, b};

// Assign the 8-bit sum to the output s
assign s = sum[7:0];

// Detect overflow
// Overflow occurs when the signs of the two operands are the same,
// but the sign of the result is different.
wire a_sign = a[7];
wire b_sign = b[7];
wire s_sign = s[7];
assign overflow = (a_sign == b_sign) && (a_sign != s_sign);

endmodule
