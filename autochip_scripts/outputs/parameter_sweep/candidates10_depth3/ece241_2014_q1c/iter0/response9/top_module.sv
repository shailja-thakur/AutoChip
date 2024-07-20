module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	reg [8:0] sum;
	reg overflow;
	
	always @(*) begin
		sum = a + b; // Calculate the sum
		overflow = (sum[8] != sum[7]); // Check for overflow
	end
	
	assign s = sum[7:0]; // Output the sum
	
endmodule
