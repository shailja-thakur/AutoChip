module top_module (
	input clk,
	input x,
	output z
);
	// Define register s as 3 bits with initial value of 0
	reg [2:0] s = 3'b000;
	
	always @(posedge clk) begin
		// Statement 1
		s[2] <= x ^ s[2];
		s[0] <= x;
		
		// Statement 2
		s[1] <= ~s[1] & x;
		
		// Statement 3
		s[0] <= ~s[0] | x;
	end
	
	// Assign output z
	assign z = ~(|s);
	
endmodule
