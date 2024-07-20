module top_module (
	input clk,
	input x,
	output z
);
	// Define register s and its initial value
	reg [2:0] s = 3'b000;
	
	// Always block to update the state of s
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
