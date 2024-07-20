module top_module (
	input clk,
	input x,
	output reg z
);

	reg [2:0] s = 3'b000; // 3-bit register 's' initialized to 0

	always @(posedge clk) begin
		// Statement 1
		s[2] <= s[2] ^ x; // The MSB of s is XORed with x
		s[0] <= x; // The value of x is assigned to the LSB of s

		// Statement 2
		s[1] <= x & ~s[1]; // The middle bit of s is ANDed with the NOT of the middle bit of s

		// Statement 3
		s[0] <= x | ~s[0]; // The LSB of s is x ORed with the NOT of the LSB of s
	end

	always @(*) begin
		z = ~(|s); // The OR of all bits of s is NOTed and assigned to z
	end
endmodule
