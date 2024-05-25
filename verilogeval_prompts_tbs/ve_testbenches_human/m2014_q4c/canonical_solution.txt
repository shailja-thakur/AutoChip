
	always@(posedge clk) begin
		if (r)
			q <= 0;
		else
			q <= d;
	end

endmodule
