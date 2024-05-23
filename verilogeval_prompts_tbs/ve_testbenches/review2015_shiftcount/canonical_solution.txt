	
	always @(posedge clk) begin
		if (shift_ena)
			q <= { q[2:0], data };
		else if (count_ena)
			q <= q - 1'b1;
	end 
	
endmodule
