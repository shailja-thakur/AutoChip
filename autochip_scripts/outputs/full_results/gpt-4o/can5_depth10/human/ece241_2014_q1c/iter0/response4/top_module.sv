module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

wire [8:0] sum = {a[7], a} + {b[7], b}; // Extend to 9 bits to capture overflow

assign s = sum[7:0]; // The 8-bit sum
assign overflow = (a[7] == b[7]) && (sum[8] != a[7]); // Overflow occurs if the sign bit of sum differs from the sign bit of the operands

endmodule
