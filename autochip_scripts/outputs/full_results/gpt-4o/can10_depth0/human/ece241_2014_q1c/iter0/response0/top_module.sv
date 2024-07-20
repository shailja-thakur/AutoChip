module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
    wire signed [8:0] sum;  // Use a 9-bit wire to detect overflow

    assign sum = a + b;
    assign s = sum[7:0];
    
    // Overflow occurs if the sign of the sum does not match the sign of the inputs
    assign overflow = (a[7] & b[7] & ~sum[8]) | (~a[7] & ~b[7] & sum[8]);
    
endmodule
