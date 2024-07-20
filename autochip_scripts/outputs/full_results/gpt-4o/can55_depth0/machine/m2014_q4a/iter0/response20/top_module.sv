module top_module (
	input d,
	input ena,
	output logic q
);

	always @(*) begin
		if (ena)
			q = d;
		else
			q = q; // This is maintained by default unless reset or otherwise specified
	end

endmodule
