module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

	// Flip-flop for Y1
	always @(posedge w)
	begin
		Y1 <= y[1];
	end

	// Flip-flop for Y3
	always @(posedge w)
	begin
		Y3 <= y[3];
	end

endmodule
