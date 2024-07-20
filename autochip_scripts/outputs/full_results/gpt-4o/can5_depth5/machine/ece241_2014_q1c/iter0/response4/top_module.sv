module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
    wire [8:0] sum;
    
    // Compute the sum of a and b, with an extra bit for carry out
    assign sum = a + b;
    
    // Assign the least 8 significant bits to output s
    assign s = sum[7:0];
    
    // Check for overflow
    assign overflow = (a[7] == b[7]) && (s[7] != a[7]);
    
endmodule
