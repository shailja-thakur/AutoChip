module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    wire signed [8:0] sum;  // 9-bit wire to hold the sum to check for overflow

    assign sum = {a[7], a} + {b[7], b};  // Concatenate sign bits for 9-bit signed addition
    assign s = sum[7:0];  // The lower 8 bits are the result
    assign overflow = (sum[8] != sum[7]);  // Overflow if the sign bit of the 9-bit result does not match the 8-bit result's sign bit

endmodule
