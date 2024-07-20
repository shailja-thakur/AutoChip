module top_module (
	input clk,
	input x,
	output z
);
	
	reg [2:0] s = 3'b000; // Define register s as 3 bits and initialize it to 0

	always @(posedge clk) begin
		// Statement 1
		s[2] <= s[1] ^ x;
		s[0] <= x;
		
		// Statement 2
		s[1] <= ~s[1] & x;
		
		// Statement 3
		s[0] <= ~s[0] | x;
	end
	
	assign z = ~|s; // Apply OR operation to all bits of s and negate the result to assign to z
	
endmodule
