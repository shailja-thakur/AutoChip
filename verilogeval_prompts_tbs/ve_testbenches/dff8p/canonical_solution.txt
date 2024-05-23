	
	always @(negedge clk)
		if (reset)
			q <= 8'h34;
		else
			q <= d;
	
endmodule
