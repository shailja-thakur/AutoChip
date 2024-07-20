module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
    wire [8:0] sum; // 9-bit wire to store sum including carry out

    assign sum = a + b; // Add the two 8-bit inputs
    assign s = sum[7:0]; // Assign the 8 least significant bits to the output `s`
    assign overflow = (a[7] & b[7] & ~sum[8]) | (~a[7] & ~b[7] & sum[8]); // Check for overflow

endmodule
