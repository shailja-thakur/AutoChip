module top_module (
	input clk,
	input x,
	output z
);

	reg [2:0] s;

	initial begin
		s = 3'b000;
	end

	always @(posedge clk) begin
		// Statement 1
		s[2] <= x ^ s[2];   // MSB of s is exclusive ORed with x
	end

	always @(posedge clk) begin
		// Statement 2
		s[1] <= x & ~s[1];  // Middle bit of s is NOT of middle bit and x
	end

	always @(posedge clk) begin
		// Statement 3
		s[0] <= x | ~s[0];  // LSB of s is x ORed with negation of LSB
	end

	assign z = ~(s[2] | s[1] | s[0]); // OR all bits of s and then NOT

endmodule
