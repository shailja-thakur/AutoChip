module top_module (
	input d,
	input ena,
	output logic q
);

	always @(ena or d)
		if (ena)
			q <= d;
endmodule
