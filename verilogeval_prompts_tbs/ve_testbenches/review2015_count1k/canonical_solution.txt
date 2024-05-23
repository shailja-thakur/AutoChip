	
	always @(posedge clk)
		if (reset || q == 999)
			q <= 0;
		else
			q <= q+1;
	
endmodule
