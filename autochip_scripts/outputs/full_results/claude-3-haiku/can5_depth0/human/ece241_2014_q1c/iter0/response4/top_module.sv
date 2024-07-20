module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

wire [8:0] sum;

// Add the two 8-bit numbers and generate a 9-bit sum
assign sum = {1'b0, a} + {1'b0, b};

// Assign the 8 least significant bits of the sum to the output s
assign s = sum[7:0];

// Detect overflow by checking the most significant bits of the sum
// If a and b have the same sign, but the sign of the sum is different, then overflow has occurred
assign overflow = (~a[7] & ~b[7] & sum[7]) | (a[7] & b[7] & ~sum[7]);

endmodule
