module top_module (
	input [6:1] y,
	input w,
	output reg Y2,
	output reg Y4
);

	reg [6:1] y_bits;

	always @ (*)
	begin
		y_bits = y;
		Y2 = y_bits[1] & ~w;
		Y4 = y_bits[2] & y_bits[3] & y_bits[5] & y_bits[6] & w;
	end

endmodule
