module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

wire [6:1] y_and = {1'b0, y[2], y[3], 1'b0, y[5], y[6]};
wire Y2 = y[1] & ~w;
wire Y4 = y_and & w;

endmodule
