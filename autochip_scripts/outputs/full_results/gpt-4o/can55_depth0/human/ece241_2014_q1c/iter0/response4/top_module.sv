module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
    wire [8:0] sum;

    // Perform the addition with one extra bit to capture the carry/overflow
    assign sum = {a[7], a} + {b[7], b};

    // The result sum (s) is the lower 8 bits of sum
    assign s = sum[7:0];

    // Overflow occurs if the sign bit of sum[8] is different from the sign bit of sum[7]
    assign overflow = (sum[8] != sum[7]);

endmodule
