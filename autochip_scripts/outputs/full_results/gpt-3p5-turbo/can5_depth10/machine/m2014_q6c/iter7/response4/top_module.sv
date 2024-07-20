module top_module (
	input [6:1] y,
	input w,
	output reg Y2,
	output reg Y4
);

	always @ (*)
	begin
		Y2 = y[1] & ~w;
		Y4 = {y[5], y[4], y[2], y[1]} & w; // fixed index for Y4
	end

endmodule
