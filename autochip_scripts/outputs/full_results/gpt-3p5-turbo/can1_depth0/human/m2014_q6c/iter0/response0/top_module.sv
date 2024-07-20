module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

reg Y2;
reg Y4;

always @* begin
	if (y == 2'b00) begin
		if (w == 1'b0) begin
			Y2 = 1'b0;
			Y4 = 1'b1;
		end else begin
			Y2 = 1'b0;
			Y4 = 1'b0;
		end
	end else if (y == 2'b01) begin
		if (w == 1'b0) begin
			Y2 = 1'b1;
			Y4 = 1'b1;
		end else begin
			Y2 = 1'b0;
			Y4 = 1'b0;
		end
	end else if (y == 2'b10) begin
		if (w == 1'b0) begin
			Y2 = 1'b0;
			Y4 = 1'b0;
		end else begin
			Y2 = 1'b0;
			Y4 = 1'b1;
		end
	end else if (y == 2'b11) begin
		if (w == 1'b0) begin
			Y2 = 1'b0;
			Y4 = 1'b0;
		end else begin
			Y2 = 1'b0;
			Y4 = 1'b1;
		end
	end
end

endmodule
