module top_module (
	input clk,
	input x,
	output reg z
);

	reg [2:0] s = 3'b000;

	always @(posedge clk) begin
		// Statement 1
		s[2] <= s[2] ^ x;    // MSB of s is XORed with x
		s[0] <= x;           // LSB of s is assigned the value of x
		
		// Statement 2
		s[1] <= x & ~s[1];   // Middle bit of s is ANDed with the NOT of middle bit and x
		
		// Statement 3
		s[0] <= x | ~s[0];   // LSB of s is ORed with the NOT of LSB and x
	end

	assign z = ~(|s);       // OR all bits of s and apply NOT operator

endmodule
