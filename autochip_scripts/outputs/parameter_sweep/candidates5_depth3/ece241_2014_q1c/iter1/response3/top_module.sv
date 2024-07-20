module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	reg [8:0] sum;

	// Adder to compute the sum
	// Use a + b as operands
	// Result stored in sum
	always @(*) begin
		sum = a + b;
	end
	
	// Assign s as result of sum
	assign s = sum[7:0];
	
	// Compute overflow flag based on MSB carry out
	assign overflow = sum[8] ^ sum[7];

endmodule
