module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

    wire [7:0] sum;
    assign sum = a + b;
    assign s = sum;

    // Check if a and b have the same sign and s has a different sign
    assign overflow = (a[7] == b[7]) && (a[7] != sum[7]);
    
endmodule
