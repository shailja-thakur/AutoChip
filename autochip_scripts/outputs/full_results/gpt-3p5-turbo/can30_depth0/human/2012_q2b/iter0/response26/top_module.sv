module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

	reg Y1_reg, Y3_reg;

	always @(posedge w) begin
		Y1_reg <= y[1];
		Y3_reg <= y[3];
	end

	assign Y1 = Y1_reg;
	assign Y3 = Y3_reg;

endmodule
