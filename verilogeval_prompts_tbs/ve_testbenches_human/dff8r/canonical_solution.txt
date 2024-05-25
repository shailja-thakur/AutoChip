	
	always @(posedge clk)
		if (reset)
			q <= 0;
		else
			q <= d;
	
endmodule
