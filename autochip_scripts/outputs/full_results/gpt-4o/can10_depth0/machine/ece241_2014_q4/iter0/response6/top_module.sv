module top_module (
	input clk,
	input x,
	output z
);
	// Define a 3-bit register 's' with initial value 0
	reg [2:0] s = 0;
	
	always @(posedge clk) begin
		// MSB operation
		s[2] <= x ^ s[2];
		// Middle bit operation
		s[1] <= x & ~s[1];
		// LSB operation
		s[0] <= x | ~s[0];
	end
	
	// Assign output z
	assign z = ~ (s[2] | s[1] | s[0]);
endmodule
