module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);
	reg [6:1] y_temp;

	assign Y2 = y_temp[1] & ~w;
	assign Y4 = y_temp[6:5] & y_temp[3:2] & w;

	always @(y, w)
	begin
		y_temp = y;
	end
endmodule
