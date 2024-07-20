module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);
	wire [6:1] y_trim;
	
	assign y_trim = y[6:1];

	assign Y2 = y_trim[1] & ~w;
	assign Y4 = y_trim[2] & y_trim[3] & y_trim[5] & y_trim[6] & w;

endmodule
