module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

    wire [8:0] sum;  // 9-bit wire to hold the sum including carry out

    assign sum = a + b;  // add inputs a and b
    assign s = sum[7:0];  // assign lower 8 bits to output s
     
    // Check for overflow: 
    // Overflow occurs if MSB of inputs are the same and different from MSB of the result
    assign overflow = (a[7] ~^ b[7]) & (a[7] ^ sum[7]);

endmodule
