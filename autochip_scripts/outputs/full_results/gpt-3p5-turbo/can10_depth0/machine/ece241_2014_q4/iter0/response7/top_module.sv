module top_module (
	input clk,
	input x,
	output z
);

	reg [2:0] s;
	
	always @(posedge clk) begin
		// Statement 1
		s[2] <= s[1] ^ x;
		s[0] <= x;
		
		// Statement 2
		s[1] <= ~s[1] & x;
		
		// Statement 3
		s[0] <= ~s[0] | x;
	end

	assign z = ~(|s);

endmodule
