module top_module (
	input d,
	input ena,
	output logic q
);
	always_ff @(ena, d) begin
		if (ena)
			q <= d;
		end
endmodule
