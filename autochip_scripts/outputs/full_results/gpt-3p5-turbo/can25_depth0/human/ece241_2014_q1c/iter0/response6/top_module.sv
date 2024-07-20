module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	reg [8:0] sum;
	
	// Perform addition
	always @(*) begin
		sum = a + b;
	end
	
	// Assign result of addition to s
	assign s = sum[7:0];
	
	// Check for overflow
	assign overflow = (sum[8] != sum[7]);
	
endmodule
