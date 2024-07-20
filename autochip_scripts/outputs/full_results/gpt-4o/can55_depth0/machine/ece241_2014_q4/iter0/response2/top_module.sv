module top_module (
	input clk,
	input x,
	output reg z
);

	reg [2:0] s;

	// Initialize the register s to 0
	initial begin
		s = 3'b000;
	end

	always @(posedge clk) begin
		// Statement 1
		s[2] <= s[2] ^ x; // MSB of s is exclusive ORed with x
		s[0] <= x;        // LSB of s is assigned the value of x

		// Statement 2
		s[1] <= x & ~s[1]; // AND operation of x and NOT of middle bit of s

		// Statement 3
		s[0] <= x | ~s[0]; // OR operation of x and NOT of LSB of s
	end

	// Assign output z
	always @(s) begin
		z = ~(s[2] | s[1] | s[0]); // OR all bits of s, then NOT the output
	end

endmodule
