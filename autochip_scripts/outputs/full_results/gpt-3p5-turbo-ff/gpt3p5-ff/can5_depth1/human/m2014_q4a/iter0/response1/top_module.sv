module top_module (
	input d,
	input ena,
	output logic q
);
	always @ (ena, d)
		if (ena)
			q <= d;
endmodule
