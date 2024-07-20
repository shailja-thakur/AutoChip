module top_module (
	input clk,
	input x,
	output reg z
);

	reg [2:0] s = 3'b000;

	always @(posedge clk) begin
		// Statement 1
		s[2] <= x ^ s[2];  // x XOR with the MSB of s
		// Statement 2
		s[1] <= x & ~s[1];  // x AND with NOT of the middle bit of s
		// Statement 3
		s[0] <= x | ~s[0];  // x OR with NOT of the LSB of s
	end

	// Assign output z
	assign z = ~|s;  // OR all bits of s and then apply NOT

endmodule
