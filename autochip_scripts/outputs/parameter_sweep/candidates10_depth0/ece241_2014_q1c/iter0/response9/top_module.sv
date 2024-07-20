module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	reg [7:0] sum;
	reg overflow;
	
	always @(*) begin
		// Perform addition
		sum = a + b;
		
		// Check for overflow
		overflow = (a[7] & b[7] & ~sum[7]) | (~a[7] & ~b[7] & sum[7]);
	end
	
	assign s = sum;
	
endmodule
