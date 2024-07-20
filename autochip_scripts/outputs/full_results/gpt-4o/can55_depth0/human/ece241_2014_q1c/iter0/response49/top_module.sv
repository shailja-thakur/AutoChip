module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
    wire [8:0] sum;
    
    //Perform addition, using a wire with an extra bit to detect overflow.
    assign sum = {a[7], a} + {b[7], b};
    assign s = sum[7:0];
    
    // Check for signed overflow.
    // Overflow occurs if the sign bit of a and b are the same, but the sign bit of the sum is different.
    assign overflow = (a[7] == b[7]) && (s[7] != a[7]);

endmodule
