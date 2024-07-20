module top_module (
	input clk,
	input x,
	output reg z
);

	reg [2:0] s;

	initial begin
		s = 3'b000;
	end

	always @(posedge clk) begin
		// Statement 1
		s[2] <= x ^ s[2]; // MSB of s
		// Statement 2
		s[1] <= x & ~s[1]; // Middle bit of s
		// Statement 3
		s[0] <= x | ~s[0]; // LSB of s
	end

	always @(posedge clk) begin
		z <= ~(s[2] | s[1] | s[0]);
	end

endmodule
