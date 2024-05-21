	
	always @(posedge clk)
		if (reset)
			q <= 0;
		else if (slowena) begin
			if (q == 9)
				q <= 0;
			else
				q <= q+1;
		end
	
endmodule
