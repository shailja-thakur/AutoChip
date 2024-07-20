module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

assign Y1 = (y == 6'b010000 || y == 6'b100000) ? ~w : w;
assign Y3 = (y == 6'b010000 || y == 6'b100000) ? w : ~w;

endmodule
