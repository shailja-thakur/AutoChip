module top_module (
	input clk,
	input x,
	output reg z
);

	// Register definitions
	reg [2:0] s = 3'b000;

	always @(posedge clk) begin
		// Statement 1
		s[2] = s[2];
		s[2] = x ^ s[2];
		s[0] = x;
		
		// Statement 2
		s[1] = ~s[1];
		s[1] = x & s[1];
		
		// Statement 3
		s[0] = ~s[0];
		s[0] = x | s[0];
	end

	// Assign output z
	assign z = ~(s[2] | s[1] | s[0]);

endmodule
