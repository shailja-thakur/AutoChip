module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

// Add the two 8-bit numbers
wire [8:0] sum = {1'b0, a} + {1'b0, b};

// Assign the 8-bit sum output
assign s = sum[7:0];

// Determine if an overflow has occurred
// Overflow occurs when the most significant bits of the 9-bit sum are not the same
assign overflow = (sum[8] != sum[7]);

endmodule
