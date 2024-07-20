module top_module (
	input d,
	input ena,
	output logic q
);

	always @(ena)
	begin
		if(ena)
			q = d;
	end

endmodule
