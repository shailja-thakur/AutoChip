	
	always @(posedge clk, posedge areset)
		if (areset)
			q <= 0;
		else
			q <= d;
	
endmodule
