module top_module (
	input [6:1] y,
	input w,
	output reg Y2,
	output reg Y4
);

	reg [3:0] y_bits;

	always @ (*)
	begin
		Y2 = y[1] & ~w;
		y_bits = {y[6], y[5], y[3], y[2]};
		Y4 = y_bits & w;
	end

endmodule
