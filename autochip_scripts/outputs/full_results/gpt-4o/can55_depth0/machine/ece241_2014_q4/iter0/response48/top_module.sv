module top_module (
	input clk,
	input x,
	output z
);

	reg [2:0] s = 3'b000; // 3-bit register s initialized to 0
	wire msb; // Most Significant Bit
	wire middle; // Middle bit
	wire lsb; // Least Significant Bit

	always @(posedge clk) begin
		// Statement 1
		msb = s[2];
		s[2] = x ^ msb;

		// Statement 2
		middle = s[1];
		s[1] = x & ~middle;

		// Statement 3
		lsb = s[0];
		s[0] = x | ~lsb;
	end
	
	assign z = ~|(s); // Output z is the NOT of the OR of all bits of s

endmodule
