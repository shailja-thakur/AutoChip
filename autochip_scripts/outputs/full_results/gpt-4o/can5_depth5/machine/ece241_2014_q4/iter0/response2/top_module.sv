module top_module (
	input clk,
	input x,
	output reg z // make z a reg since it will be driven inside an always block
);

	reg [2:0] s = 3'b000; // 3-bit register s with initial value 0

	always @(posedge clk) begin
		// Statement 1
		s[2] <= x ^ s[2];
		// Statement 2
		s[1] <= x & ~s[1];
		// Statement 3
		s[0] <= x | ~s[0];
	end

	always @(s) begin
		// Assign output z
		z <= ~(|s);
	end

endmodule
