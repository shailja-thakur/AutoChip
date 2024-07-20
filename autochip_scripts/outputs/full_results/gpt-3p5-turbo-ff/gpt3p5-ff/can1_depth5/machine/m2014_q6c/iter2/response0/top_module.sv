module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);
	// Create intermediate signals to represent individual bits of y
	reg [6:1] y_temp;

	// Assign values to intermediate signals
	always @(y)
	begin
		y_temp = y;
	end

	// Calculate Y2
	assign Y2 = y_temp[1] & ~w;

	// Calculate Y4
	assign Y4 = y_temp[2] & y_temp[3] & y_temp[5] & y_temp[6] & w;

endmodule
