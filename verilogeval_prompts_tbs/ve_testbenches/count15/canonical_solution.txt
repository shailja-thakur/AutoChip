	
	always @(posedge clk)
		if (reset)
			q <= 0;
		else
			q <= q+1;
	
endmodule
