module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

    wire [8:0] sum; // Use a 9-bit wire to capture the carry out

    assign sum = a + b; // Perform the addition
    assign s = sum[7:0]; // Assign the lower 8 bits to the output

    // Check if there is an overflow
    assign overflow = (a[7] & b[7] & ~sum[7]) | (~a[7] & ~b[7] & sum[7]);

endmodule
