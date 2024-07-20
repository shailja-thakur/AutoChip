module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
    
    wire [7:0] sum;
    wire carry_out;

    assign {carry_out, sum} = a + b;
    assign s = sum;

    // Check for signed overflow
    assign overflow = ((a[7] & b[7] & ~sum[7]) | (~a[7] & ~b[7] & sum[7]));

endmodule
