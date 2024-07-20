module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

    wire [8:0] sum;

    // Perform the addition with carry bit.
    assign sum = {a[7], a} + {b[7], b};
    
    // Produce the sum output
    assign s = sum[7:0];
    
    // An overflow occurs if the carry in to the sign bit is different from the carry out of the sign bit.
    assign overflow = (a[7] == b[7]) && (s[7] != a[7]);

endmodule
