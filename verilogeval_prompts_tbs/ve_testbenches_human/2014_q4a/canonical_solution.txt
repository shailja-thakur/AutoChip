
	always @(posedge clk)
		if (L)
			Q <= R;
		else if (E)
			Q <= w;
	
endmodule
