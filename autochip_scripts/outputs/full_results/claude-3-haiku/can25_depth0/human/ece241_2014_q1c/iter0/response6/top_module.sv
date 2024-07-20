module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

// Perform the addition
wire [8:0] sum = {1'b0, a} + {1'b0, b};

// Assign the sum output
assign s = sum[7:0];

// Compute the overflow condition
// Overflow occurs when the most significant bits of the 9-bit sum are not the same
assign overflow = (sum[8] ^ sum[7]);

endmodule
