module top_module (
	input d,
	input ena,
	output logic q
);

	always @(*) begin
		if (ena) 
			q = d;
		else 
			q = q;  // Retain previous value
	end

endmodule
