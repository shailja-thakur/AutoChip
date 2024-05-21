	
	always @(posedge clk)
		if (reset || q == 9)
			q <= 0;
		else
			q <= q+1;
	
endmodule
