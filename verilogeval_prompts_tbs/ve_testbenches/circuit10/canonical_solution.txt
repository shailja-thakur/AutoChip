
	reg c;
	always @(posedge clk)
		c <= a&b | a&c | b&c;
	
	assign q = a^b^c;
	assign state = c;
			
endmodule
