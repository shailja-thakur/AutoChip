module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

    // Intermediate sum including carry out
	wire [8:0] sum_extended;
	
	assign sum_extended = {a[7], a} + {b[7], b};
	assign s = sum_extended[7:0];
	
	// Overflow occurs if the carry into the sign bit is different from the carry out of the sign bit
	assign overflow = sum_extended[8] ^ sum_extended[7];

endmodule
