module top_module (
	input d,
	input ena,
	output logic q
);
	always @(d, ena)
		if (ena)
			q <= d;
endmodule
