module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
    wire [8:0] sum;

    // Add the two 8-bit numbers with a 9-bit wire to capture the carry
    assign sum = a + b;
    
    // The result is the lower 8 bits of the sum
    assign s = sum[7:0];
    
    // Overflow occurs if the carry into the sign bit is different from the carry out of the sign bit
    assign overflow = (a[7] == b[7]) && (a[7] != s[7]);
    
endmodule
