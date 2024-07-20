module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
    wire [8:0] sum; // 9-bit wire to store the sum including carry out

    assign sum = a + b; // Perform addition
    assign s = sum[7:0]; // Assign the least significant 8 bits to s
    assign overflow = (a[7] == b[7]) && (s[7] != a[7]); // Check for overflow

endmodule
