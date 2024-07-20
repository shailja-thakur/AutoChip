module top_module (
	input [6:1] y,
	input w,
	output logic Y2,
	output logic Y4
);

	assign Y2 = ~w & y[1];
	assign Y4 = w & (y[6] & y[5] & y[3] & y[2]);

endmodule
