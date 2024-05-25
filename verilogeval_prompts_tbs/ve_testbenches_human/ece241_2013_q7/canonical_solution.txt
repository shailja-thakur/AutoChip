
	always @(posedge clk)
		Q <= j&~Q | ~k&Q;
	
endmodule
