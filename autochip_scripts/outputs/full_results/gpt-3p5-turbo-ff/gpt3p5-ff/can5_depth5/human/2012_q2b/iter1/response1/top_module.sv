module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);
	
	// flip-flop Y1
	always @ (posedge w or negedge y[4] or negedge y[2])
	begin
		if (y[4] == 1'b1 && w == 1'b0)
			Y1 <= 1'b1;
		else if (y[2] == 1'b1 && w == 1'b1)
			Y1 <= 1'b1;
		else
			Y1 <= 1'b0;
	end
	
	// flip-flop Y3
	always @ (posedge w or negedge y[2] or negedge y[0])
	begin
		if (y[2] == 1'b1 && w == 1'b0)
			Y3 <= 1'b1;
		else if (y[0] == 1'b1 && w == 1'b1)
			Y3 <= 1'b1;
		else
			Y3 <= 1'b0;
	end

endmodule
