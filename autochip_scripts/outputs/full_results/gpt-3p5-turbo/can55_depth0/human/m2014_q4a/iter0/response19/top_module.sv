module d_latch (
	input d,
	input ena,
	output logic q
);

	always @(posedge ena) begin
		q <= d;
	end

endmodule
module top_module (
	input d,
	input ena,
	output logic q
);

	d_latch d_latch1 (
		.d(d),
		.ena(ena),
		.q(q)
	);

endmodule
