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
		// Cascade notation using a temporary register to hold previous state
		reg [2:0] s_next;
		// Statement 1
		s_next[2] = x ^ s[2]; // MSB of s
		// Statement 2
		s_next[1] = x & ~s[1]; // Middle bit of s
		// Statement 3
		s_next[0] = x | ~s[0]; // LSB of s

		// Update state
		s <= s_next;
	end

	assign z = ~(s[2] | s[1] | s[0]);

endmodule
