module top_module (
	input clk,
	input x,
	output z
);
	// Register s is 3 bits and its initial value is 0
	reg [2:0] s = 3'b0;

	// Always block
	always @(posedge clk) begin
		// Statement 1
		s[2] <= s[1] ^ x;
		s[0] <= x;

		// Statement 2
		s[1] <= ~s[1] & x;

		// Statement 3
		s[0] <= ~s[0] | x;
	end

	// Assign output z
	assign z = ~(|s);

endmodule
