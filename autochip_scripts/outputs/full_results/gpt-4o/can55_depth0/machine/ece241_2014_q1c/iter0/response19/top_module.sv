module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

    wire [8:0] sum;
    
    // Sum the inputs a and b, including the potential carry bit to detect overflow
    assign sum = a + b;
    
    // Assign the 8-bit output to the least significant 8 bits of the sum
    assign s = sum[7:0];
    
    // Overflow occurs if the sign of the sum is different from the input signs when both inputs have the same sign
    assign overflow = (a[7] == b[7]) && (s[7] != a[7]);

endmodule
