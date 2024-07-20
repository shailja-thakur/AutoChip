module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
    wire [8:0] sum; // 9-bit wire to accommodate potential carry out
    
    assign sum = a + b;
    assign s = sum[7:0];
    
    // Detect overflow: overflow occurs if the sign bit of a and b are the same,
    // but the sign bit of the result is different.
    assign overflow = (a[7] & b[7] & ~sum[7]) | (~a[7] & ~b[7] & sum[7]);
    
endmodule
