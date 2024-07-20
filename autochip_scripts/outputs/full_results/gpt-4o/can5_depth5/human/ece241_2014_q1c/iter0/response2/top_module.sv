module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

wire [8:0] sum_extended; // 9-bit wide to handle overflow bits

// Perform 8-bit addition
assign sum_extended = a + b;
assign s = sum_extended[7:0];

// Check for signed overflow
assign overflow = ((a[7] == b[7]) && (s[7] != a[7]));
 
endmodule
