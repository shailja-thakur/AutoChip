module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

    wire [8:0] sum;  // 9-bit wire to hold the sum including a possible carry out

    assign sum = a + b;
    assign s = sum[7:0];  // Assign the lower 8 bits of the sum to s
    assign overflow = (a[7] == b[7]) && (s[7] != a[7]);

endmodule
