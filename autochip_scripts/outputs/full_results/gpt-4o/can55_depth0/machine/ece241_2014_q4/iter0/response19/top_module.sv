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
		// MSB operation
		s[2] = s[2] ^ x;
		s[0] = x;
		
		// Middle bit operation
		s[1] = x & ~s[1];
		
		// LSB operation
		s[0] = x | ~s[0];
	end

	// Assign output z
	assign z = ~(|s);
endmodule
