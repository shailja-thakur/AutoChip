
	always@(posedge clk or posedge ar) begin
		if (ar)
			q <= 0;
		else
			q <= d;
	end

endmodule
