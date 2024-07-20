module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
    wire [8:0] sum;  // 9-bit wire to handle overflow

    assign sum = a + b;
    assign s = sum[7:0];

    // Overflow occurs when the sign of a and b are the same and different from the sign of s
    assign overflow = (~a[7] & ~b[7] & s[7]) | (a[7] & b[7] & ~s[7]);

endmodule
