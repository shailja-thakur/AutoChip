module top_module (
	input [6:1] y,
	input w,
	output reg Y2,
	output reg Y4
);

	reg [3:0] y_slice;

	always @ (*)
	begin
		Y2 = y[1] & ~w;
		y_slice = y[5:2];
		Y4 = y_slice & w;
	end

endmodule
