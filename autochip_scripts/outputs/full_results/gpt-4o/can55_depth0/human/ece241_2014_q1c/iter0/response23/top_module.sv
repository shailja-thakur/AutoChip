module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
 
    assign s = a + b;
 
    // Overflow detection: overflow occurs if the sign of the sum is different from the sign of both operands
    assign overflow = (a[7] == b[7]) && (s[7] != a[7]);
 
endmodule
