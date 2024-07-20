module top_module (
	input [6:1] y,
	input w,
	output reg Y2,
	output reg Y4
);

	always @(*) begin
		Y2 = y[1] & (~w);
		if (w) begin
			Y4 = y[6] & y[5] & y[3] & y[2];
		end else begin
			Y4 = 0;
		end
	end

endmodule
