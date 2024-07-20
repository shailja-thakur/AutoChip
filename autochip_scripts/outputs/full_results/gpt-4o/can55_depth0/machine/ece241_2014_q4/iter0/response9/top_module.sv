module top_module (
	input clk,
	input x,
	output reg z
);

	reg [2:0] s = 3'b000; // 3-bit register s initialized to 0

	always @(posedge clk) begin
		// Statement 1
		s[2] <= x ^ s[2];  // MSB of s is XORed with x
		// Statement 2
		s[1] <= ~s[1] & x; // Middle bit of s AND with NOT of s[1]
		// Statement 3
		s[0] <= ~s[0] | x; // LSB of s ORed with NOT of s[0]
	end

	always @(*) begin
		z = ~(|s); // OR all bits of s and then apply NOT operator
	end

endmodule
