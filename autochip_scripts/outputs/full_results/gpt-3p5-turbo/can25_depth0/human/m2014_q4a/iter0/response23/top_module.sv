module top_module (
	input d,
	input ena,
	output logic q
);

// Adding the missing semicolon after the always keyword
always @ (ena)
	begin
		if (ena)
			q <= d;
	end

endmodule
