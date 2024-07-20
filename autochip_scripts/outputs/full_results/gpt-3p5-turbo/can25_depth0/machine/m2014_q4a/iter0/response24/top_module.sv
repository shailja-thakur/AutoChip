module top_module (
	input d,
	input ena,
	output logic q
);

	// Combinational logic
	always @* begin
		if (ena)
			q = d;
	end

endmodule
