module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
    wire [8:0] sum;

    // Perform addition with one extra bit to check for overflow
    assign sum = {a[7], a} + {b[7], b};
    // Assign the lower 8 bits to s
    assign s = sum[7:0];
    // Overflow occurs if the sign bit of sum[8] is different from the sum[7:6]
    assign overflow = (sum[8] ^ sum[7]);

endmodule
