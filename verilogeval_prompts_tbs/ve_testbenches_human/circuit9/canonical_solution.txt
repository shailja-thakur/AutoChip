
	always @(posedge clk)
		if (a)
			q <= 4;
		else if (q == 6)
			q <= 0;
		else
			q <= q + 1'b1;
			
endmodule
