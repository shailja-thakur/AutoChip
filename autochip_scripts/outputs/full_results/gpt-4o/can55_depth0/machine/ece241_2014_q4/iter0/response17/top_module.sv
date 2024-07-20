module top_module (
	input clk,
	input x,
	output reg z
);

	reg [2:0] s = 3'b000;

	always @(posedge clk) begin
		// Statement 1: Update MSB and LSB
		s[2] <= x ^ s[2];
		s[0] <= x | ~s[0];
		// Statement 2: Update middle bit
		s[1] <= x & ~s[1];
	end

	// Assign output z
	always @(*) begin
		z = ~(|s);
	end

endmodule
