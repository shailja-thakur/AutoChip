	
	always @(posedge clk)
		if (reset || q == 10)
			q <= 1;
		else
			q <= q+1;
	
endmodule
