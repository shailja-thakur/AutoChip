module top_module (
	input d,
	input ena,
	output logic q
);

	always @(*) begin
		if (ena) begin
			q = d;
		end
		// If ena is not set, q retains its previous value implicitly
	end

endmodule
