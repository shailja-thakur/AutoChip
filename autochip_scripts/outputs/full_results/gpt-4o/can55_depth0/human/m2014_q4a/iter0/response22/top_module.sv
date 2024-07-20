module top_module (
	input d,
	input ena,
	output logic q
);

	always @(*) begin
		if (ena) begin
			q = d;
		end
		// No else statement needed; q holds its value when ena is low
	end

endmodule
