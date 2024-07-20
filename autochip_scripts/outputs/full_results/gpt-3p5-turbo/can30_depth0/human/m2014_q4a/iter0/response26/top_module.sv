module top_module (
	input d,
	input ena,
	output logic q
);
	always @(d, ena) begin
		if (ena)
			q <= d;
	end
endmodule
