module top_module (
	input d,
	input ena,
	output logic q
);
	// D latch implementation
	always @(posedge ena)
	begin
		if (ena)
			q <= d;
	end

endmodule
