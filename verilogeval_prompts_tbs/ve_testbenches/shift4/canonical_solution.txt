	
	
	always @(posedge clk, posedge areset) begin
		if (areset)
			q <= 0;
		else if (load)
			q <= data;
		else if (ena)
			q <= q[3:1];
	end
endmodule
