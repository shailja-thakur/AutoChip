module top_module (
	input [6:1] y,
	input w,
	output reg Y2,
	output reg Y4
);

	reg [5:1] y_bits;

	assign y_bits = y[5:1];

	always @ (*)
	begin
		Y2 = y[1] & ~w;
		Y4 = y_bits & w;
	end

endmodule
