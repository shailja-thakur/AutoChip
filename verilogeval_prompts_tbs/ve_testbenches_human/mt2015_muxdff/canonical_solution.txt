
	initial Q=0;
	always @(posedge clk)
		Q <= L ? r_in : q_in;
	
endmodule
