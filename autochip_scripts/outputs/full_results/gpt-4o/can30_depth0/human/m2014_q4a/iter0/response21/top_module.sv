module top_module (
	input d,
	input ena,
	output logic q
);

	// Always block to implement the D latch behavior
	always @(*) begin
		if (ena) begin
			q = d;
		end
		// No need for an else clause since q retains its value when ena is low
	end

endmodule
