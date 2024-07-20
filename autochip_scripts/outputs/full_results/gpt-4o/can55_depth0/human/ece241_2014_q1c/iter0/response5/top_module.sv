module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	
	// Declare intermediate wire to hold the full addition result (9 bits for overflow detection)
	wire [8:0] full_sum;
	
	// Perform the addition
	assign full_sum = {a[7], a} + {b[7], b};
	assign s = full_sum[7:0];

	// Check for overflow: 
	// Overflow occurs when the sign of the inputs match, but the sign of the output differs.
	assign overflow = (a[7] == b[7]) && (s[7] != a[7]);

endmodule
