	
	initial
		q = 8'h0;
		
	always @(posedge clk)
		q <= d;
	
endmodule
