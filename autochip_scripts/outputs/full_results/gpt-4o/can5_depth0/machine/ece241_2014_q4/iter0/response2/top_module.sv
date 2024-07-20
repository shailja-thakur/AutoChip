module top_module (
	input clk,
	input x,
	output z
);

	reg [2:0] s = 3'b000; // 3-bit register s initialized to 0

	always @(posedge clk) begin
		// Statement 1
		s[2] <= x ^ s[2]; // MSB
		s[0] <= x; // LSB
		
		// Statement 2
		s[1] <= x & ~s[1]; // Middle bit
		
		// Statement 3
		s[0] <= x | ~s[0]; // LSB
	end

	assign z = ~(|s); // OR all bits of s and then NOT the result

endmodule
