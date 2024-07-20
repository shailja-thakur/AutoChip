module top_module (
	input clk,
	input x,
	output reg z
);

	reg [2:0] s; // 3-bit register s

	// Initialize s to 0
	initial begin
		s = 3'b000;
	end

	// Always block
	always @(posedge clk) begin
		// Statement 1
		s[2] = s[2] ^ x;
		// Move the new value of s[2] into s[0]
		s[0] = x;

		// Statement 2
		s[1] = ~s[1] & x;

		// Statement 3
		s[0] = x | ~s[0];
	end

	// Assign output z
	always @(s) begin
		z = ~(|s);
	end

endmodule
