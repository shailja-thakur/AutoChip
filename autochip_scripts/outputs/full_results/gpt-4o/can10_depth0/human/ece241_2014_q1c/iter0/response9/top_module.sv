module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
    wire [7:0] sum;
    wire carry_out;

    // Perform addition
    assign sum = a + b;
    assign s = sum;

    // Check for signed overflow
    // Overflow occurs if the sign of the sum differs from the signs of both operands, 
    // and the signs of the operands were the same.
    assign overflow = (~a[7] & ~b[7] & sum[7]) | (a[7] & b[7] & ~sum[7]);
endmodule
